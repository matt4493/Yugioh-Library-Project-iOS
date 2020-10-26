

	public ArrayList<String> getAllSimilarCardsForAdvanceSearch(
			String main_card_type_checkvalue, String card_name,
			String description, String card_sub_type, String main_card_type,
			String card_secondary_type, String card_secondary_type_clearCheck,
			String attribute_type, String level_rank_stars, String lessThanATK,
			String greaterThanATK, String lessThanDEF, String greaterThanDEF,
			String passCodeNum, String setname) {
		ArrayList<String> returnedSimilarNames;
		ArrayList<String> NoResults = null;
		String sql_query_similar_cards = null;
		NoResults = new ArrayList<String>();
		NoResults.add("No results found.");
		returnedSimilarNames = new ArrayList<String>();

		if (setname.length() != 0) {
			String sql_query_cardSet = "SELECT " + "set_ini"
					+ " FROM sets WHERE full_set_name like \"%" + setname
					+ "%\"";
			Cursor c_cardset = myDatabaseR.rawQuery(sql_query_cardSet, null);
			c_cardset.moveToFirst();
			if (c_cardset != null) {
				String returnedCardSet = c_cardset.getString(c_cardset
						.getColumnIndex("set_ini"));
				if (main_card_type_checkvalue.equalsIgnoreCase("Monster")) {
					if (card_sub_type.equalsIgnoreCase("Normal")) {
						if (card_secondary_type_clearCheck
								.equalsIgnoreCase("Secondary Type Clear")) {
							sql_query_similar_cards = "SELECT card_name FROM cards WHERE description like \"%"
									+ description
									+ "%\" AND "
									+ "(card_type not like \"pendulum\" AND card_type not like \"%Fusion%\" AND card_type not like \"%Effect%\" AND card_type not like \"%Ritual%\" AND "
									+ "card_type not like \"%Xyz%\" AND card_type not like \"%Synchro%\" AND card_type not like \"%Union%\" AND "
									+ "card_type not like \"%Spirit%\" AND card_type not like \"%Toon%\" AND card_type not like \"%trap%\" AND "
									+ "card_type not like \"%spell%\" AND card_type not like \"%Tuner%\") OR "
									+ "(card_name='Water Spirit' OR card_name='Flamvell Guard' OR card_name='Genex Controller' OR card_name='Tuner Warrior' OR "
									+ "card_name='Ally Mind') AND "
									+ "attribute_type like \"%"
									+ attribute_type
									+ "%\" AND "
									+ "(level_stars like \"%"
									+ level_rank_stars
									+ "%\" OR rank_stars like \"%"
									+ level_rank_stars
									+ "%\") AND "
									+ "(atk_points >= "
									+ lessThanATK
									+ " AND atk_points <= "
									+ greaterThanATK
									+ ") AND "
									+ "(def_points >= "
									+ lessThanDEF
									+ " AND def_points <= "
									+ greaterThanDEF
									+ ") AND "
									+ "setini like \"%"
									+ returnedCardSet
									+ "%\" AND "
									+ "card_number like \"%"
									+ passCodeNum
									+ "%\" ORDER BY card_name ASC;";

						} else if (card_secondary_type
								.equalsIgnoreCase("Tuner")) {
							sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name='Matthewergerg'";
							sql_query_similar_cards = "SELECT card_name FROM cards WHERE description like \"%"
									+ description
									+ "%\" AND "
									+ "(card_name='Water Spirit' OR card_name='Flamvell Guard' OR card_name='Genex Controller' OR card_name='Tuner Warrior' OR "
									+ "card_name='Ally Mind') AND "
									+ "card_type like \"%"
									+ main_card_type
									+ "%\" AND "
									+ "attribute_type like \"%"
									+ attribute_type
									+ "%\" AND "
									+ "(level_stars like \"%"
									+ level_rank_stars
									+ "%\" OR rank_stars like \"%"
									+ level_rank_stars
									+ "%\") AND "
									+ "(atk_points >= "
									+ lessThanATK
									+ " AND atk_points <= "
									+ greaterThanATK
									+ ") AND "
									+ "(def_points >= "
									+ lessThanDEF
									+ " AND def_points <= "
									+ greaterThanDEF
									+ ") AND "
									+ "setini like \"%"
									+ returnedCardSet
									+ "%\" AND "
									+ "card_number like \"%"
									+ passCodeNum
									+ "%\" ORDER BY card_name ASC;";
						} else {
							sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
									+ card_name
									+ "%\" AND "
									+ "description like \"%"
									+ description
									+ "%\" AND "
									+ "(description not like \"%Add%\" OR description not like \"%You can pay%\" OR description not like \"%Once per turn%\""
									+ " AND description not like \"%Special Summon%\""
									+ " AND description not like \"%During your Main Phase%\" OR description not like \"%While in Attack Position%\""
									+ " AND description not like \"%While in Defense Position%\" OR description not like \"%you can add%\""
									+ " AND description not like \"%Synchro Material Monster%\" OR description not like \"%sent to the Graveyard%\""
									+ " AND description not like \"%sent from the%\" OR description not like \"%when this%\" OR description not like \"%when this card%\""
									+ " AND description not like \"%if this card%\" OR description not like \"%while this card%\" OR description not like \"%if your%\""
									+ " AND description not like \"%when you take%\" OR description not like \"%when this removed%\" OR description not like \"%all face-up%\""
									+ " AND description not like \"%during either player's%\" OR description not like \"%during damage calculation%\" OR description not like \"%this card%\") "
									+ "AND "
									+ "card_type like \"%"
									+ ""
									+ "%\" AND card_type like \"%"
									+ main_card_type
									+ "%\" AND "
									+ "card_type not like \"pendulum\" AND card_type not like \"%Fusion%\" AND card_type not like \"%Effect%\" AND card_type not like \"%Ritual%\" AND "
									+ "card_type not like \"%Xyz%\" AND card_type not like \"%Synchro%\" AND card_type not like \"%Union%\" AND "
									+ "card_type not like \"%Spirit%\" AND card_type not like \"%Toon%\" AND card_type not like \"%Gemini%\" AND "
									+ "card_type not like \"%Normal%\" AND "
									+ "card_type like \"%"
									+ card_secondary_type
									+ "%\" AND attribute_type like \"%"
									+ attribute_type
									+ "%\" AND "
									+ "level_stars like \"%"
									+ level_rank_stars
									+ "%\" AND "
									+ "(atk_points >= "
									+ lessThanATK
									+ " AND atk_points <= "
									+ greaterThanATK
									+ ") AND "
									+ "(def_points >= "
									+ lessThanDEF
									+ " AND def_points <= "
									+ greaterThanDEF
									+ ") AND "
									+ "setini like \"%"
									+ returnedCardSet
									+ "%\" AND "
									+ "card_number like \"%"
									+ passCodeNum
									+ "%\" ORDER BY card_name ASC;";
						}
					} else if (card_sub_type.equalsIgnoreCase("Effect")) {
						if (card_secondary_type_clearCheck
								.equalsIgnoreCase("Secondary Type Clear")) {
							sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
									+ card_name
									+ "%\" AND "
									+ "(description like \"%Add%\" OR description like \"%You can pay%\" OR description like \"%Once per turn%\""
									+ " OR description like \"%During your Main Phase%\" OR description like \"%While in Attack Position%\""
									+ " OR description like \"%While in Defense Position%\" OR description like \"%you can add%\""
									+ " OR description like \"%Synchro Material Monster%\" OR description like \"%sent to the Graveyard%\""
									+ " OR description like \"%sent from the%\" OR description like \"%when this%\" OR description like \"%when this card%\""
									+ " OR description like \"%if this card%\" OR description like \"%while this card%\" OR description like \"%if your%\""
									+ " OR description like \"%when you take%\" OR description like \"%when this removed%\" OR description like \"%all face-up%\""
									+ " OR description like \"%during either player's%\" OR description like \"%during damage calculation%\" OR description like \"%this card%\") "
									+ "AND "
									+ "card_type not like \"%Card%\" AND "
									+ "(card_type like \"%Effect%\" OR card_type like \"%Gemini%\" OR card_type like \"%Spirit%\" OR card_type like \"%Toon%\""
									+ " OR card_type like \"%Union%\" OR card_type like \"%"
									+ "Tuner"
									+ "%\") AND "
									+ "card_type like \"%"
									+ main_card_type
									+ "%\" AND "
									+ "attribute_type like \"%"
									+ attribute_type
									+ "%\" AND "
									+ "(level_stars like \"%"
									+ level_rank_stars
									+ "%\" OR rank_stars like \"%"
									+ level_rank_stars
									+ "%\") AND "
									+ "(atk_points >= "
									+ lessThanATK
									+ " AND atk_points <= "
									+ greaterThanATK
									+ ") AND "
									+ "(def_points >= "
									+ lessThanDEF
									+ " AND def_points <= "
									+ greaterThanDEF
									+ ") AND "
									+ "setini like \"%"
									+ returnedCardSet
									+ "%\" AND "
									+ "card_number like \"%"
									+ passCodeNum
									+ "%\" ORDER BY card_name ASC;";

						} else {
							sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
									+ card_name
									+ "%\" AND "
									+ "(description like \"%Add%\" OR description like \"%You can pay%\" OR description like \"%Once per turn%\""
									+ " OR description like \"%During your Main Phase%\" OR description like \"%While in Attack Position%\""
									+ " OR description like \"%While in Defense Position%\" OR description like \"%you can add%\""
									+ " OR description like \"%Synchro Material Monster%\" OR description like \"%sent to the Graveyard%\""
									+ " OR description like \"%sent from the%\" OR description like \"%when this%\" OR description like \"%when this card%\""
									+ " OR description like \"%if this card%\" OR description like \"%while this card%\" OR description like \"%if your%\""
									+ " OR description like \"%when you take%\" OR description like \"%when this removed%\" OR description like \"%all face-up%\""
									+ " OR description like \"%during either player's%\" OR description like \"%during damage calculation%\" OR description like \"%this card%\") "
									+ "AND "
									+ "card_type not like \"%Card%\" AND "
									+ "card_type like \"%"
									+ card_secondary_type
									+ "%\" AND "
									+ "card_type like \"%"
									+ main_card_type
									+ "%\" AND "
									+ "attribute_type like \"%"
									+ attribute_type
									+ "%\" AND "
									+ "(level_stars like \"%"
									+ level_rank_stars
									+ "%\" OR rank_stars like \"%"
									+ level_rank_stars
									+ "%\") AND "
									+ "(atk_points >= "
									+ lessThanATK
									+ " AND atk_points <= "
									+ greaterThanATK
									+ ") AND "
									+ "(def_points >= "
									+ lessThanDEF
									+ " AND def_points <= "
									+ greaterThanDEF
									+ ") AND "
									+ "setini like \"%"
									+ returnedCardSet
									+ "%\" AND "
									+ "card_number like \"%"
									+ passCodeNum
									+ "%\" ORDER BY card_name ASC;";
						}

					} else {
						sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
								+ card_name
								+ "%\" AND "
								+ "description like \"%"
								+ description
								+ "%\" AND "
								+ "card_type like \"%"
								+ card_sub_type
								+ "%\" AND card_type like \"%"
								+ main_card_type
								+ "%\" AND "
								+ "card_type not like \"%Card%\" AND "
								+ "card_type like \"%"
								+ card_secondary_type
								+ "%\" AND attribute_type like \"%"
								+ attribute_type
								+ "%\" AND "
								+ "(level_stars like \"%"
								+ level_rank_stars
								+ "%\" OR rank_stars like \"%"
								+ level_rank_stars
								+ "%\") AND "
								+ "(atk_points >= "
								+ lessThanATK
								+ " AND atk_points <= "
								+ greaterThanATK
								+ ") AND "
								+ "(def_points >= "
								+ lessThanDEF
								+ " AND def_points <= "
								+ greaterThanDEF
								+ ") AND "
								+ "setini like \"%"
								+ returnedCardSet
								+ "%\" AND "
								+ "card_number like \"%"
								+ passCodeNum
								+ "%\" ORDER BY card_name ASC;";
					}
				} else if (main_card_type_checkvalue.equalsIgnoreCase("Spell")) {
					sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
							+ card_name
							+ "%\" AND "
							+ "description like \"%"
							+ description
							+ "%\" AND "
							+ "card_type like \"%"
							+ card_sub_type
							+ "%\" AND card_type like \"%"
							+ main_card_type
							+ "%\" AND "
							+ "card_type not like \"%Spellcaster%\" AND card_type not like \"%Trap Card%\" AND "
							+ "card_type like \"%"
							+ card_secondary_type
							+ "%\" AND "
							+ "setini like \"%"
							+ returnedCardSet
							+ "%\" AND "
							+ "card_number like \"%"
							+ passCodeNum
							+ "%\" ORDER BY card_name ASC;";
				} else if (main_card_type_checkvalue.equalsIgnoreCase("Trap")) {
					sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
							+ card_name
							+ "%\" AND "
							+ "description like \"%"
							+ description
							+ "%\" AND "
							+ "card_type like \"%"
							+ card_sub_type
							+ "%\" AND card_type like \"%"
							+ main_card_type
							+ "%\" AND "
							+ "card_type not like \"%Spell Card%\" AND "
							+ "card_type like \"%"
							+ card_secondary_type
							+ "%\" AND "
							+ "setini like \"%"
							+ returnedCardSet
							+ "%\" AND "
							+ "card_number like \"%"
							+ passCodeNum
							+ "%\" ORDER BY card_name ASC;";
				} else {
					sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
							+ card_name
							+ "%\" AND "
							+ "description like \"%"
							+ description
							+ "%\" AND "
							+ "card_type like \"%"
							+ card_sub_type
							+ "%\" AND card_type like \"%"
							+ main_card_type
							+ "%\" AND "
							+ "card_type like \"%"
							+ card_secondary_type
							+ "%\" AND attribute_type like \"%"
							+ attribute_type
							+ "%\" AND "
							+ "(level_stars like \"%"
							+ level_rank_stars
							+ "%\" OR rank_stars like \"%"
							+ level_rank_stars
							+ "%\") AND "
							+ "(atk_points >= "
							+ lessThanATK
							+ " AND atk_points <= "
							+ greaterThanATK
							+ ") AND "
							+ "(def_points >= "
							+ lessThanDEF
							+ " AND def_points <= "
							+ greaterThanDEF
							+ ") AND "
							+ "setini like \"%"
							+ returnedCardSet
							+ "%\" AND "
							+ "card_number like \"%"
							+ passCodeNum
							+ "%\" ORDER BY card_name ASC;";
				}
			}

			Cursor c_similarCards = myDatabaseR.rawQuery(
					sql_query_similar_cards, null);
			c_similarCards.moveToFirst();
			if (c_similarCards != null) {
				do {
					if (c_similarCards.getCount() > 0) {
						String returnedName = c_similarCards
								.getString(c_similarCards
										.getColumnIndex(KEY_CARDNAME));
						returnedSimilarNames.add(returnedName);
					} else {
						c_cardset.close();
						c_similarCards.close();
						return NoResults;
					}
				} while (c_similarCards.moveToNext());
				c_cardset.close();
				c_similarCards.close();
				return returnedSimilarNames;
			}
		} else {
			if (main_card_type_checkvalue.equalsIgnoreCase("Monster")) {
				if (card_sub_type.equalsIgnoreCase("Normal")) {
					if (card_secondary_type_clearCheck
							.equalsIgnoreCase("Secondary Type Clear")) {
						sql_query_similar_cards = "SELECT card_name FROM cards WHERE description like \"%"
								+ description
								+ "%\" AND "
								+ "(card_type not like \"pendulum\" AND card_type not like \"%Fusion%\" AND card_type not like \"%Effect%\" AND card_type not like \"%Ritual%\" AND "
								+ "card_type not like \"%Xyz%\" AND card_type not like \"%Synchro%\" AND card_type not like \"%Union%\" AND "
								+ "card_type not like \"%Spirit%\" AND card_type not like \"%Toon%\" AND card_type not like \"%trap%\" AND "
								+ "card_type not like \"%spell%\" AND card_type not like \"%Tuner%\") OR "
								+ "(card_name='Water Spirit' OR card_name='Flamvell Guard' OR card_name='Genex Controller' OR card_name='Tuner Warrior' OR "
								+ "card_name='Ally Mind') AND "
								+ "attribute_type like \"%"
								+ attribute_type
								+ "%\" AND "
								+ "(level_stars like \"%"
								+ level_rank_stars
								+ "%\" OR rank_stars like \"%"
								+ level_rank_stars
								+ "%\") AND "
								+ "(atk_points >= "
								+ lessThanATK
								+ " AND atk_points <= "
								+ greaterThanATK
								+ ") AND "
								+ "(def_points >= "
								+ lessThanDEF
								+ " AND def_points <= "
								+ greaterThanDEF
								+ ") AND "
								+ "card_number like \"%"
								+ passCodeNum + "%\" ORDER BY card_name ASC;";

					} else if (card_secondary_type.equalsIgnoreCase("Tuner")) {
						sql_query_similar_cards = "SELECT card_name FROM cards WHERE description like \"%"
								+ description
								+ "%\" AND "
								+ "(card_name='Water Spirit' OR card_name='Flamvell Guard' OR card_name='Genex Controller' OR card_name='Tuner Warrior' OR "
								+ "card_name='Ally Mind') AND "
								+ "card_type like \"%"
								+ main_card_type
								+ "%\" AND "
								+ "attribute_type like \"%"
								+ attribute_type
								+ "%\" AND "
								+ "(level_stars like \"%"
								+ level_rank_stars
								+ "%\" OR rank_stars like \"%"
								+ level_rank_stars
								+ "%\") AND "
								+ "(atk_points >= "
								+ lessThanATK
								+ " AND atk_points <= "
								+ greaterThanATK
								+ ") AND "
								+ "(def_points >= "
								+ lessThanDEF
								+ " AND def_points <= "
								+ greaterThanDEF
								+ ") AND "
								+ "card_number like \"%"
								+ passCodeNum + "%\" ORDER BY card_name ASC;";
					} else {
						sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
								+ card_name
								+ "%\" AND "
								+ "description like \"%"
								+ description
								+ "%\" AND "
								+ "(description not like \"%Add%\" OR description not like \"%You can pay%\" OR description not like \"%Once per turn%\""
								+ " AND description not like \"%Special Summon%\""
								+ " AND description not like \"%During your Main Phase%\" OR description not like \"%While in Attack Position%\""
								+ " AND description not like \"%While in Defense Position%\" OR description not like \"%you can add%\""
								+ " AND description not like \"%Synchro Material Monster%\" OR description not like \"%sent to the Graveyard%\""
								+ " AND description not like \"%sent from the%\" OR description not like \"%when this%\" OR description not like \"%when this card%\""
								+ " AND description not like \"%if this card%\" OR description not like \"%while this card%\" OR description not like \"%if your%\""
								+ " AND description not like \"%when you take%\" OR description not like \"%when this removed%\" OR description not like \"%all face-up%\""
								+ " AND description not like \"%during either player's%\" OR description not like \"%during damage calculation%\" OR description not like \"%this card%\") "
								+ "AND "
								+ "card_type like \"%"
								+ ""
								+ "%\" AND card_type like \"%"
								+ main_card_type
								+ "%\" AND "
								+ "card_type not like \"pendulum\" AND card_type not like \"%Fusion%\" AND card_type not like \"%Effect%\" AND card_type not like \"%Ritual%\" AND "
								+ "card_type not like \"%Xyz%\" AND card_type not like \"%Synchro%\" AND card_type not like \"%Union%\" AND "
								+ "card_type not like \"%Spirit%\" AND card_type not like \"%Toon%\" AND card_type not like \"%Gemini%\" AND "
								+ "card_type not like \"%Normal%\" AND card_type not like \"%Tuner%\" AND "
								+ "card_type like \"%"
								+ card_secondary_type
								+ "%\" AND attribute_type like \"%"
								+ attribute_type
								+ "%\" AND "
								+ "(level_stars like \"%"
								+ level_rank_stars
								+ "%\" OR rank_stars like \"%"
								+ level_rank_stars
								+ "%\") AND "
								+ "(atk_points >= "
								+ lessThanATK
								+ " AND atk_points <= "
								+ greaterThanATK
								+ ") AND "
								+ "(def_points >= "
								+ lessThanDEF
								+ " AND def_points <= "
								+ greaterThanDEF
								+ ") AND "
								+ "card_number like \"%"
								+ passCodeNum + "%\" ORDER BY card_name ASC;";
					}
				} else if (card_sub_type.equalsIgnoreCase("Effect")) {
					if (card_secondary_type_clearCheck
							.equalsIgnoreCase("Secondary Type Clear")) {
						sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
								+ card_name
								+ "%\" AND "
								+ "(description like \"%Add%\" OR description like \"%You can pay%\" OR description like \"%Once per turn%\""
								+ " OR description like \"%During your Main Phase%\" OR description like \"%While in Attack Position%\""
								+ " OR description like \"%While in Defense Position%\" OR description like \"%you can add%\""
								+ " OR description like \"%Synchro Material Monster%\" OR description like \"%sent to the Graveyard%\""
								+ " OR description like \"%sent from the%\" OR description like \"%when this%\" OR description like \"%when this card%\""
								+ " OR description like \"%if this card%\" OR description like \"%while this card%\" OR description like \"%if your%\""
								+ " OR description like \"%when you take%\" OR description like \"%when this removed%\" OR description like \"%all face-up%\""
								+ " OR description like \"%during either player's%\" OR description like \"%during damage calculation%\" OR description like \"%this card%\") "
								+ "AND "
								+ "card_type not like \"%Card%\" AND "
								+ "(card_type like \"%Effect%\" OR card_type like \"%Gemini%\" OR card_type like \"%Spirit%\" OR card_type like \"%Toon%\""
								+ " OR card_type like \"%Union%\" OR card_type like \"%"
								+ "Tuner"
								+ "%\") AND "
								+ "card_type like \"%"
								+ main_card_type
								+ "%\" AND "
								+ "attribute_type like \"%"
								+ attribute_type
								+ "%\" AND "
								+ "(level_stars like \"%"
								+ level_rank_stars
								+ "%\" OR rank_stars like \"%"
								+ level_rank_stars
								+ "%\") AND "
								+ "(atk_points >= "
								+ lessThanATK
								+ " AND atk_points <= "
								+ greaterThanATK
								+ ") AND "
								+ "(def_points >= "
								+ lessThanDEF
								+ " AND def_points <= "
								+ greaterThanDEF
								+ ") AND "
								+ "card_number like \"%"
								+ passCodeNum + "%\" ORDER BY card_name ASC;";

					} else {
						sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
								+ card_name
								+ "%\" AND "
								+ "(description like \"%Add%\" OR description like \"%You can pay%\" OR description like \"%Once per turn%\""
								+ " OR description like \"%During your Main Phase%\" OR description like \"%While in Attack Position%\""
								+ " OR description like \"%While in Defense Position%\" OR description like \"%you can add%\""
								+ " OR description like \"%Synchro Material Monster%\" OR description like \"%sent to the Graveyard%\""
								+ " OR description like \"%sent from the%\" OR description like \"%when this%\" OR description like \"%when this card%\""
								+ " OR description like \"%if this card%\" OR description like \"%while this card%\" OR description like \"%if your%\""
								+ " OR description like \"%when you take%\" OR description like \"%when this removed%\" OR description like \"%all face-up%\""
								+ " OR description like \"%during either player's%\" OR description like \"%during damage calculation%\" OR description like \"%this card%\") "
								+ "AND "
								+ "card_type not like \"%Card%\" AND "
								+ "card_type like \"%"
								+ card_secondary_type
								+ "%\" AND "
								+ "card_type like \"%"
								+ main_card_type
								+ "%\" AND "
								+ "attribute_type like \"%"
								+ attribute_type
								+ "%\" AND "
								+ "(level_stars like \"%"
								+ level_rank_stars
								+ "%\" OR rank_stars like \"%"
								+ level_rank_stars
								+ "%\") AND "
								+ "(atk_points >= "
								+ lessThanATK
								+ " AND atk_points <= "
								+ greaterThanATK
								+ ") AND "
								+ "(def_points >= "
								+ lessThanDEF
								+ " AND def_points <= "
								+ greaterThanDEF
								+ ") AND "
								+ "card_number like \"%"
								+ passCodeNum + "%\" ORDER BY card_name ASC;";
					}
				} else {
					sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
							+ card_name
							+ "%\" AND "
							+ "description like \"%"
							+ description
							+ "%\" AND "
							+ "card_type like \"%"
							+ card_sub_type
							+ "%\" AND card_type like \"%"
							+ main_card_type
							+ "%\" AND "
							+ "card_type not like \"%Card%\" AND "
							+ "card_type like \"%"
							+ card_secondary_type
							+ "%\" AND attribute_type like \"%"
							+ attribute_type
							+ "%\" AND "
							+ "(level_stars like \"%"
							+ level_rank_stars
							+ "%\" OR rank_stars like \"%"
							+ level_rank_stars
							+ "%\") AND "
							+ "(atk_points >= "
							+ lessThanATK
							+ " AND atk_points <= "
							+ greaterThanATK
							+ ") AND "
							+ "(def_points >= "
							+ lessThanDEF
							+ " AND def_points <= "
							+ greaterThanDEF
							+ ") AND "
							+ "card_number like \"%"
							+ passCodeNum
							+ "%\" ORDER BY card_name ASC;";
				}
			} else if (main_card_type_checkvalue.equalsIgnoreCase("Spell")) {
				sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
						+ card_name
						+ "%\" AND "
						+ "description like \"%"
						+ description
						+ "%\" AND "
						+ "card_type like \"%"
						+ card_sub_type
						+ "%\" AND card_type like \"%"
						+ main_card_type
						+ "%\" AND "
						+ "card_type not like \"%Spellcaster%\" AND card_type not like \"%Trap Card%\" AND "
						+ "card_type like \"%"
						+ card_secondary_type
						+ "%\" AND attribute_type like \"%"
						+ attribute_type
						+ "%\" AND "
						+ "(level_stars like \"%"
						+ level_rank_stars
						+ "%\" OR rank_stars like \"%"
						+ level_rank_stars
						+ "%\") AND "
						+ "(atk_points >= "
						+ lessThanATK
						+ " AND atk_points <= "
						+ greaterThanATK
						+ ") AND "
						+ "(def_points >= "
						+ lessThanDEF
						+ " AND def_points <= "
						+ greaterThanDEF
						+ ") AND "
						+ "card_number like \"%"
						+ passCodeNum
						+ "%\" ORDER BY card_name ASC;";
			} else if (main_card_type_checkvalue.equalsIgnoreCase("Trap")) {
				sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
						+ card_name
						+ "%\" AND "
						+ "description like \"%"
						+ description
						+ "%\" AND "
						+ "card_type like \"%"
						+ card_sub_type
						+ "%\" AND card_type like \"%"
						+ main_card_type
						+ "%\" AND "
						+ "card_type not like \"%Spell Card%\" AND "
						+ "card_type like \"%"
						+ card_secondary_type
						+ "%\" AND attribute_type like \"%"
						+ attribute_type
						+ "%\" AND "
						+ "(level_stars like \"%"
						+ level_rank_stars
						+ "%\" OR rank_stars like \"%"
						+ level_rank_stars
						+ "%\") AND "
						+ "(atk_points >= "
						+ lessThanATK
						+ " AND atk_points <= "
						+ greaterThanATK
						+ ") AND "
						+ "(def_points >= "
						+ lessThanDEF
						+ " AND def_points <= "
						+ greaterThanDEF
						+ ") AND "
						+ "card_number like \"%"
						+ passCodeNum
						+ "%\" ORDER BY card_name ASC;";
			} else {
				sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
						+ card_name
						+ "%\" AND "
						+ "description like \"%"
						+ description
						+ "%\" AND "
						+ "card_type like \"%"
						+ card_sub_type
						+ "%\" AND card_type like \"%"
						+ main_card_type
						+ "%\" AND "
						+ "card_type like \"%"
						+ card_secondary_type
						+ "%\" AND attribute_type like \"%"
						+ attribute_type
						+ "%\" AND "
						+ "(level_stars like \"%"
						+ level_rank_stars
						+ "%\" OR rank_stars like \"%"
						+ level_rank_stars
						+ "%\") AND "
						+ "(atk_points >= "
						+ lessThanATK
						+ " AND atk_points <= "
						+ greaterThanATK
						+ ") AND "
						+ "(def_points >= "
						+ lessThanDEF
						+ " AND def_points <= "
						+ greaterThanDEF
						+ ") AND "
						+ "card_number like \"%"
						+ passCodeNum
						+ "%\" ORDER BY card_name ASC;";
			}
			Cursor c_similarCards = myDatabaseR.rawQuery(
					sql_query_similar_cards, null);
			c_similarCards.moveToFirst();
			if (c_similarCards != null) {
				do {
					if (c_similarCards.getCount() > 0) {
						String returnedName = c_similarCards
								.getString(c_similarCards
										.getColumnIndex(KEY_CARDNAME));
						returnedSimilarNames.add(returnedName);
					} else {
						c_similarCards.close();
						return NoResults;
					}
				} while (c_similarCards.moveToNext());
				c_similarCards.close();
				return returnedSimilarNames;
			}
		}
		return NoResults;

	}

	