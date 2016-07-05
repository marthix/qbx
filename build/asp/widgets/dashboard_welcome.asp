<div class="box box-warning">
	<div class="box-header with-border">
		<h3 class="box-title"><b>Welcome to The QB<sup>X</sup></b></h3>
	</div>
	<div class="box-body">
		<div style="padding-bottom: 10px;">The Quarterback Exchange is a <b><i>free</i></b> fantasy stock market game structured around NFL quarterback on-field performances. This is a <b><i>game</i></b>. No actual money is exchanged.</div>
		<div style="padding-bottom: 10px;">The game operates on a particular set of rules and stock prices are set by our advanced statistical formulaic algorithm. Get to know the rules and math below.</div>
		<button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#rules">Exchange Rules & Information</button>
		<button type="button" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#pricing">Pricing Formula</button>
	</div>
</div>

<div id="rules" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 50%;">
	
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Exchange Rules & Information</h4>
			</div>
			<div class="modal-body">
			
				<div style="padding-bottom: 10px;">Alright, folks, let's get this one thing out of the way first... The Quarterback Exchange is a <em><strong>free</strong></em> fantasy stock market game structured around NFL quarterback on-field performances. This is a <em><strong>game</strong></em>. No actual money is exchanged.</div>
				<div style="padding-bottom: 10px;">Prices update Tuesday morning and the Exchange will be open between Tuesday morning and the following Thursday night kick-off. Obviously, you will only be able to buy and sell shares when the Exchange is open.</div>
				<div style="padding-bottom: 20px;">The Quarterback Exchange is currently in BETA and should not be talked about. Think "Fight Club" when considering to invite any friends. If you want to invite a friend or two, that's fine, but we won't be marketing this game until we're sure that the bugs have been squashed and we move to more powerful and reliable servers.</div>
				
				<dl class="dl-horizontal">
					<dt>Portfolio Limits</dt>
					<dd style="padding-bottom: 10px;">The Exchange does not operate on a tier-system, so you are free to add as many quarterbacks as you would like. There are no restrictions.</dd>
					<dt>Transaction Limits</dt>
					<dd style="padding-bottom: 10px;">The Exchange does not limit your number of transactions. As long as the Exchange is open, you may buy and sell with no restrictions.</dd>
					<dt>Earning Interest</dt>
					<dd style="padding-bottom: 10px;">Each week, when the Exchange share prices are updated, your current cash holdings will gain 5% interest.</dd>
					<dt>Quarterback Degradation</dt>
					<dd style="padding-bottom: 10px;">Each week that a quarterback does not play, their share value is decreased by 5%. This only applies to quarterbacks who have played at least one game in the current season. Quarterbacks who haven't played any games will retain the same value until they play in a game.</dd>
					<dt>Account Recovery</dt>
					<dd style="padding-bottom: 10px;">We currently don't have e-mail setup for QB<sup>X</sup>, so if you forget your password just <a href="mailto:samelevel@gmail.com">contact me</a> to have it reset. We should have e-mail capabilities by mid-season and we'll build a proper "forgot your password" tool at that point.</dd>
					<dt>Mobile Access</dt>
					<dd style="padding-bottom: 10px;">The QB<sup>X</sup> is built on a responsive framework, so it will adapt to your device size. With that being said, the QB<sup>X</sup> is built with desktop in mind. Yes, it will work on your phone, but it is recommended to use your desktop.</dd>
					<dt>Advertisements</dt>
					<dd style="padding-bottom: 10px;">The QB<sup>X</sup> is partnered with Google AdSense and we earn revenue based on advertisement impressions and clicks. We would appreciate it if our users disabled any ad-blocking software they may have installed. Oh, and please click the ads.</dd>
					<dt>BETA Disclaimer</dt>
					<dd>The QB<sup>X</sup> is currently in BETA release. This means we have a small number of people using an app that hasn't really passed any sort of extensive testing. We <strong><em>will</em></strong> run into problems and we <strong><em>will</em></strong> work through said problems. Whatever you do, stay calm. The Commissioner reserves the right to reverse any transactions in the event of an emergency price change.</dd>
				</dl>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
			
		</div>
		
	</div>
</div>

<div id="pricing" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 50%;">
	
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Pricing Formula</h4>
			</div>
			<div class="modal-body">
			
			<pre style="overflow: auto; word-wrap: normal; white-space: pre;">Function SetWeekly (qb_ID, game_Year, game_Week)

  sqlGetTracker = "SELECT samelevel.qbx_tracker.tracker_ID FROM samelevel.qbx_tracker " & _
                  "INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID " & _
                  "WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " " & _
                  "AND samelevel.qbx_games.game_Year = " & game_Year & " " & _
                  "AND samelevel.qbx_games.game_Week = " & game_Week - 1
  Set rsTracker = sqlSameLevel.Execute(sqlGetTracker)
  
  If rsTracker.Eof Then
  
    sqlGetLastPrice = "SELECT price_Value FROM qbx_prices " & _
                      "WHERE qbx_prices.qb_ID = " & qb_ID & " " & _
                      "AND qbx_prices.game_Year = " & game_Year & " " & _
                      "AND qbx_prices.game_Week = " & game_Week - 1
    Set rsLastPrice = sqlSameLevel.Execute(sqlGetLastPrice)
    
    LastPrice = rsLastPrice("price_Value")

    sqlGetAllSeason = "SELECT samelevel.qbx_tracker.tracker_ID FROM samelevel.qbx_tracker " & _
                      "INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID " & _
                      "WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " " & _
                      "AND samelevel.qbx_games.game_Year = " & game_Year & " " & _
                      "AND samelevel.qbx_games.game_Week < " & game_Week
    Set rsAllSeason = sqlSameLevel.Execute(sqlGetAllSeason)
    
    Final_Price = LastPrice
    
    If Not rsAllSeason.Eof Then Final_Price = FormatNumber(CDbl(LastPrice) * 0.95, 2)

  Else

    game_Count = 1
	
    sqlGetYTD = "SELECT samelevel.qbx_tracker.*, samelevel.qbx_games.* FROM samelevel.qbx_tracker " & _
                "INNER JOIN samelevel.qbx_games ON samelevel.qbx_games.game_ID = samelevel.qbx_tracker.game_ID " & _
                "WHERE samelevel.qbx_tracker.qb_ID = " & qb_ID & " " & _
                "AND samelevel.qbx_games.game_Year = " & game_Year & " " & _
                "AND samelevel.qbx_games.game_Week < " & game_Week & " " & _
                "ORDER BY samelevel.qbx_games.game_Year DESC, samelevel.qbx_games.game_Week DESC"
    Set rsYTD = sqlSameLevel.Execute(sqlGetYTD)

    Do While Not rsYTD.Eof

      If game_Count < 21 Then game_Weight = "0.4"
      If game_Count < 19 Then game_Weight = "0.8"
      If game_Count < 17 Then game_Weight = "1.2"
      If game_Count < 15 Then game_Weight = "1.6"
      If game_Count < 13 Then game_Weight = "2.0"
      If game_Count < 11 Then game_Weight = "2.4"
      If game_Count < 9  Then game_Weight = "2.8"
      If game_Count < 7  Then game_Weight = "3.2"
      If game_Count < 5  Then game_Weight = "3.6"
      If game_Count < 3  Then game_Weight = "4.0"

      this_QBR     = rsYTD("tracker_QBR")
      this_Starter = rsYTD("tracker_Starter")
      this_Victory = rsYTD("tracker_Victory")
      this_PaAtt   = rsYTD("tracker_PassingAttempts")
      this_PaComp  = rsYTD("tracker_PassingCompletions")
      this_PaYDS   = rsYTD("tracker_PassingYards")
      this_PaTD    = rsYTD("tracker_PassingTouchdowns")
      this_RuYDS   = rsYTD("tracker_RushingYards")
      this_RuTD    = rsYTD("tracker_RushingTouchdowns")
      this_INT     = rsYTD("tracker_PassingInterceptions")
      this_Fum     = rsYTD("tracker_FumblesLost")
      this_Team    = rsYTD("team_ID")
      
      this_game_Week     = rsYTD("game_Week")
      this_game_HomeTeam = rsYTD("game_HomeTeam_ID")
      this_game_AwayTeam = rsYTD("game_AwayTeam_ID")
	  
      If this_game_Week > 17 Then game_Weight = game_Weight * 2
      If this_game_Week = 21 Then game_Weight = game_Weight * 2

      this_Home = 0
      this_Away = 0
      
      If CInt(this_Team) = CInt(this_game_HomeTeam) Then
        this_Home = 1
      Else
        this_Away = 1
      End If

      If IsNull(this_QBR) Then    this_QBR = 0.0
      If IsNull(this_PaAtt) Then  this_PaAtt = 0.0
      If IsNull(this_PaComp) Then this_PaComp = 0.0
      If IsNull(this_PaYDS) Then  this_PaYDS = 0.0
      If IsNull(this_PaTD) Then   this_PaTD = 0.0
      If IsNull(this_RuYDS) Then  this_RuYDS = 0.0
      If IsNull(this_RuTD) Then   this_RuTD = 0.0
      If IsNull(this_INT) Then    this_INT = 0.0
      If IsNull(this_Fum) Then    this_Fum = 0.0

      If this_Starter Then total_Starts = total_Starts + 1

      If this_Starter And this_Victory Then
        If this_Home Then total_Victories = total_Victories + game_Weight
        If this_Away Then total_Victories = total_Victories + (game_Weight * 1.1)
      End If

      If this_Starter And Not this_Victory Then
        If this_Home Then total_Losses = total_Losses + (game_Weight * 1.1)
        If this_Away Then total_Losses = total_Losses + game_Weight
      End If

      total_QBR = total_QBR + (this_QBR)
      total_PaAtt = total_PaAtt + (this_PaAtt * game_Weight)
      total_PaComp = total_PaComp + (this_PaComp * game_Weight)
      total_PaYDS = total_PaYDS + (this_PaYDS * game_Weight)
      total_PaTD = total_PaTD + (this_PaTD * game_Weight)
      total_RuYDS = total_RuYDS + (this_RuYDS * game_Weight)
      total_RuTD = total_RuTD + (this_RuTD * game_Weight)
      total_INT = total_INT + (this_INT * game_Weight)
      total_Fum = total_Fum + (this_Fum * game_Weight)

      game_Count = game_Count + 1

      rsYTD.MoveNext

    Loop

    rsYTD.Close
    Set rsYTD = Nothing

    qbr_Score = 0
    PaComp_Score = 0
    Pa_YDS_Score = 0
    PaTD_Score = 0
    Ru_YDS_Score = 0
    RuTD_Score = 0
    WL_Score = 0
    INT_Score = 0
    Fum_Score = 0

    If total_PaAtt > 0 Then PaComp_Score = FormatNumber(((total_PaComp / total_PaAtt) * 15), 2)
    qbr_Score = FormatNumber((CDbl(total_QBR) / game_Count) / 6, 2)
    Pa_YDS_Score = FormatNumber((CDbl(total_PaYDS) / game_Count) / 50, 2)
    PaTD_Score = FormatNumber((CDbl(total_PaTD) / game_Count) * 3, 2)
    Ru_YDS_Score = FormatNumber((CDbl(total_RuYDS) / game_Count) / 25, 2)
    RuTD_Score = FormatNumber((CDbl(total_RuTD) / game_Count) * 4, 2)
    WL_Score = FormatNumber(((total_Victories - total_Losses) / 2), 2)
    INT_Score = FormatNumber((CDbl(total_INT) / game_Count) * 6, 2)
    Fum_Score = FormatNumber((CDbl(total_Fum) / game_Count) * 6, 2)

    rsTracker.Close
    Set rsTracker = Nothing

    Final_Price = CDbl(qbr_Score) + CDbl(PaComp_Score) + CDbl(Pa_YDS_Score) + CDbl(PaTD_Score) + CDbl(Ru_YDS_Score) + CDbl(RuTD_Score) + CDbl(WL_Score) - CDbl(INT_Score) - CDbl(Fum_Score)

  End If

  If Final_Price < 5 Then Final_Price = 5

  SetWeekly = FormatNumber(Final_Price, 2)

End Function</pre>
			
			
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
			
		</div>
		
	</div>
</div>