using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OleDb;

namespace MLSCansole
{
    class Program
    {
        public static DataTable datatable_CSV;
        static void Main(string[] args)
        {
            Console.WriteLine("Enter Input file full path:");
            String inputFilePath = Console.ReadLine();
            if (!File.Exists(inputFilePath))
            {
                Console.WriteLine("File not found, Enter any key to close.");
                Console.ReadKey();
            }
            else if (!(inputFilePath.Substring(inputFilePath.LastIndexOf('.')+1).ToLower() == "csv"))
            {
                Console.WriteLine("File with this extension not supported, Enter any key to close.");
                Console.ReadKey();
            }
            else
            {
                try
                {
                    MLSCansole.ComanClass obj = new ComanClass();
                    datatable_CSV = obj.GetDataTableFromCSVFile(inputFilePath);
                    DataView view = new DataView(datatable_CSV);
                    DataTable distinctValues = view.ToTable(true, "ML#");
                    String outputFilePath = System.Configuration.ConfigurationManager.AppSettings.Get("outputFile").ToString();
                  // string outputFilePath="C:\\outputFile_ml.csv";
                    using (StreamWriter writer = new StreamWriter(outputFilePath))
                    {
                        Rfc4180Writer.WriteDataTable(distinctValues, writer, true);
                    }
                    Console.WriteLine("Done, your output file is saved to Location " + outputFilePath + ".");
                    Console.WriteLine("Enter any key to close.");
                    Console.ReadKey();
                }
                catch(Exception ex) {
                    Console.WriteLine("Error: "+ex.ToString());
                    Console.WriteLine("Enter any key to close.");
                    Console.ReadKey();
                }
            }
        }
    }
    public static class Rfc4180Writer
    {
        public static void WriteDataTable(DataTable sourceTable, TextWriter writer, bool includeHeaders)
        {
            if (includeHeaders)
            {
                List<string> headerValues = new List<string>();
                foreach (DataColumn column in sourceTable.Columns)
                {
                    headerValues.Add(QuoteValue(column.ColumnName));
                }

                writer.WriteLine(String.Join(",", headerValues.ToArray()));
            }

            string[] items = null;
            foreach (DataRow row in sourceTable.Rows)
            {
                items = row.ItemArray.Select(o => QuoteValue(o.ToString())).ToArray();
                writer.WriteLine(String.Join(",", items));
            }

            writer.Flush();
        }

        private static string QuoteValue(string value)
        {
            return String.Concat("\"", value.Replace("\"", "\"\""), "\"");
        }
    }
}