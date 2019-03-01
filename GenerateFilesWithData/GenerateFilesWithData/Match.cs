using System;

namespace GenerateFilesWithData
{
    public class Match
    {
        public int Id { get; set; }
        public int HomeTeamId { get; set; }
        public int AwayTeamId { get; set; }
        public int ManagerId { get; set; }
        public int LocationId { get; set; }
        public int SportId { get; set; }
        public int TournamentId { get; set; }
        public bool IsStarted { get; set; }
        public int ScoreHomeTeam { get; set; }
        public int ScoreAwayTeam { get; set; }
        public DateTime Date { get; set; }

        public Match(int id, int homeTeamId, int awayTeamId, int managerId, int locationId, int sportId,
            int tournamentId, bool isStarted, int ScoreHomeTeam, int ScoreAwayTeam, DateTime date)
        {
            this.Id = id;
            this.HomeTeamId = homeTeamId;
            this.AwayTeamId = awayTeamId;
            this.ManagerId = managerId;
            this.LocationId = locationId;
            this.SportId = sportId;
            this.TournamentId = tournamentId;
            this.IsStarted = IsStarted;
            this.ScoreHomeTeam = ScoreHomeTeam;
            this.ScoreAwayTeam = ScoreAwayTeam;
            this.Date = date;
        }
    }
}     