using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace GenerateFilesWithData
{
    class Program
    {
        static int countObject = 500;
        static void Main(string[] args)
        {
            Console.Write("Enter the amount to fill (default: 500): ");
            try
            {
                countObject = Convert.ToInt32(Console.ReadLine());
            }
            catch (Exception)
            {
                countObject = 500;
            }
            Console.WriteLine($"Will be generated {countObject} objects in formats csv and json.");
            Thread.Sleep(1000);

            var jsonTask = new Task(() =>
                {
                    string jsonFilePath = @"E:\dataMatches.json";
                    GenerateJson(jsonFilePath);
                });
            jsonTask.Start();
            var csvTask = new Task(() =>
            {
                string csvFilePath = @"E:\dataMatches.csv";
                GenerateCsv(csvFilePath);
            });
            csvTask.Start();
            
           

            Console.ReadLine();
        }

        static void GenerateCsv(string csvFilePath)
        {
            if (!File.Exists(csvFilePath))
            {
                //File.Create(csvFilePath);
                var header = string.Format($"Id,HomeTeamId,AwayTeamId,ManagerId,LocationId,SportId,TournamentId,IsStarted,ScoreHomeTeam,ScoreAwayTeam,Date");
                var lines = new List<string>();
                lines.Add(header);
                File.WriteAllLines(csvFilePath, lines);
            }
   
            for (int i = 0; i < countObject; i++)
            {
                var csv = new StringBuilder();

                var csvData = File.ReadAllLines(csvFilePath);

                var match = new RandomMatch().GetRandomMatch();
                match.Id = csvData.Length;
                var line = string.Format($"{match.Id},{match.HomeTeamId},{match.AwayTeamId},{match.ManagerId},{match.LocationId},{match.SportId},{match.TournamentId},{match.IsStarted},{match.ScoreHomeTeam},{match.ScoreAwayTeam},{match.Date.ToLocalTime()}");
                var lines = new List<string>();
                lines.Add(line);
                File.AppendAllLines(csvFilePath, lines);

            }
        }
        static void GenerateJson(string jsonFilePath)
        {

            if (!File.Exists(jsonFilePath))
            {
                File.WriteAllText(jsonFilePath, "");
            }

            for (int i = 0; i < countObject; i++)
            {
                var jsonData = File.ReadAllText(jsonFilePath);
                var list = JsonConvert.DeserializeObject<List<Match>>(jsonData)
                      ?? new List<Match>();

                var match = new RandomMatch().GetRandomMatch();
                match.Id = list.Count+1;
                list.Add(match);

                jsonData = JsonConvert.SerializeObject(list);
                File.WriteAllText(jsonFilePath, jsonData);

            }
        }

        private static Random gen = new Random();
        static DateTime RandomDay()
        {
            DateTime start = new DateTime(2019, 1, 1);
            DateTime end = new DateTime(2025, 1, 1);
            int range = (end - start).Days;
            return start.AddDays(gen.Next(range));
        }

        public class RandomMatch
        {
            public Match GetRandomMatch()
            {
                // Build connection string
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
                builder.DataSource = "34.73.86.174";
                builder.UserID = "sa";
                builder.Password = "SQLServer2016";
                builder.InitialCatalog = "BookmakerOLTP";

                // Connect to SQL
                Console.Write("Connecting to SQL Server ... ");


                var maxRandomSportId = 0;
                var maxRandomTournamentId = 0;
                var maxRandomTeamId = 0;

                var maxRandomLocationId = 0;

                using (SqlConnection connection = new SqlConnection(builder.ConnectionString))
                {
                    connection.Open();
                    Console.WriteLine("Done.");

                    // Create a sample database

                    String sqlGetLastSportId = "SELECT TOP 1 Id FROM [dbo].[Sports] ORDER BY Id DESC";
                    using (SqlCommand command = new SqlCommand(sqlGetLastSportId, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                maxRandomSportId = reader.GetInt32(0);
                            }
                        }

                        Console.WriteLine("Sport Id got. Done.");
                    }

                    String sqlGetLastTournamentId = "SELECT TOP 1 Id FROM [dbo].[Tournaments] ORDER BY Id DESC";
                    using (SqlCommand command = new SqlCommand(sqlGetLastTournamentId, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                maxRandomTournamentId = reader.GetInt32(0);
                            }
                        }

                        Console.WriteLine("Tournaments Id got. Done.");
                    }

                    String sqlGetLastTeamId = "SELECT TOP 1 Id FROM [dbo].[Teams] ORDER BY Id DESC";
                    using (SqlCommand command = new SqlCommand(sqlGetLastTeamId, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                maxRandomTeamId = reader.GetInt32(0);
                            }
                        }

                        Console.WriteLine("Teams Id got. Done.");
                    }
                    String sqlGetLastLocationId = "SELECT TOP 1 Id FROM [dbo].[Locations] ORDER BY Id DESC";
                    using (SqlCommand command = new SqlCommand(sqlGetLastLocationId, connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                maxRandomLocationId = reader.GetInt32(0);
                            }
                        }

                        Console.WriteLine("Locations Id got. Done.");
                    }


                }
                var randomSportId = new Random().Next(1, maxRandomSportId - 1);
                var randomTournamentId = new Random().Next(1, maxRandomTournamentId - 1);
                var randomHomeTeamId = new Random().Next(1, maxRandomTeamId - 1);
                var randomAwayTeamId = new Random().Next(1, maxRandomTeamId - 1);
                if (randomHomeTeamId == randomAwayTeamId)
                    randomAwayTeamId = new Random().Next(1, maxRandomTeamId - 1);

                var randomLocationId = new Random().Next(1, maxRandomLocationId - 1);
                var randomDateVar = RandomDay();

                return new Match(0, randomHomeTeamId, randomAwayTeamId, 6, randomLocationId, randomSportId, randomTournamentId, false, 0, 0, randomDateVar);
            }
        }
    }
}
