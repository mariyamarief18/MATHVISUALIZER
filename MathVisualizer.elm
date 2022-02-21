-- math-visualizer 

import Html
import Html.Attributes

tech = "https://mpng.subpng.com/20190707/beh/kisspng-picture-frames-blackboard-learn-wood-stain-green-5d21d53e2974b5.2023988515624983661698.jpg"
back = "https://www.blublub.co/wp-content/themes/blublub/assets/images/spinner.gif"
linIndep_background = "https://media1.giphy.com/media/LGMlFAeRChusjqewVV/giphy.gif"
image3Vect ="https://i.stack.imgur.com/SlvU1.gif"
fail = "https://media3.giphy.com/media/2zoCChOiQnIg40CE13/giphy.gif"
good = "https://media.giphy.com/media/tIeCLkB8geYtW/giphy.gif"
linIndep_vector = "https://media0.giphy.com/media/V9EpFr1Kg1h7t7ARQd/giphy.gif"
span_gif = "https://thumbs.gfycat.com/RealisticPlayfulCygnet.webp"
eig_gif = "https://thumbs.gfycat.com/ChillySeparateIndianrockpython.webp"
mainMenu_background = "https://i.pinimg.com/originals/9c/3f/5e/9c3f5e7411c638cb6c07253ed32a89f4.gif"

myShapes model =
    case model.state of
        MainMenu  ->
            [ 
            (html 100000 10000 <| Html.img [Html.Attributes.src mainMenu_background] [] )
                      |> scale 0.25
                      |> scaleX 1.1
                      |> move (-75,52)
                  ,text "MAIN MENU"
                  |> centered
                  |> filled black
                  |> move (0,45)
            --linear independence
            , group [ transitionButton Middle ToLinInd
                      |> scaleX 1.5
                    , text "LINEAR INDEPENDENCE"
                      |> filled white
                      |> scale 0.55
                      |> move (-38,20)
                  
                    ] |> move (0,-10)
                      |> notifyTap ToLinInd  
            , group [ transitionButton Middle ToSpan
                      |> scaleX 1.5
                    , text "SPAN"
                      |> filled white
                      |> scale 0.55
                      |> move (-7,20)
                    ] |> move (0,-30)
                      |> notifyTap ToSpan            
            , group [ transitionButton Middle ToEig
                      |> scaleX 1.5
                    , text "EIGEN-VALUES/VECTORS"
                      |> filled white
                      |> scale 0.55
                      |> move (-41,20)
                    ] |> move (0,-50)
                      |> notifyTap ToEig  ]

        LinInd  ->
            [ group[
                  (html 100000 10000 <| Html.img [Html.Attributes.src linIndep_background] [] )
                      |> scale 0.45
                      |> move (-100,65)
                   
                   ,text "LINEAR INDEPENDENCE"
                     |> size 10
                     |> centered
                     |>filled black
                     |> move (0,45)
                   , definition
                   ,( html 100000 10000 <| Html.img [Html.Attributes.src linIndep_vector] [] )
                      |> scale 0.16
                      |> move (15,28)
                      
                 ]
               
            , group [ transitionButton Right ToLinVis
                      |> scale 0.7
                      |> move (30, -10)
                    , text "VISUALIZATION"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-130,-48)
                      |> notifyTap ToLinVis       
            , group [ transitionButton Right ToLinQuiz
                      |> scale 0.7
                      |> move (30, -10)
                    , text "QUIZ"
                      |> filled white
                      |> scale 0.4
                      |> move (67,4)
                    ] |> move (-10,-48)
                      |> notifyTap ToLinQuiz
            , group [ transitionButton Right LinIndBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-70,-48)
                      |> notifyTap LinIndBack
            ]
        LinVis  ->
            [ graphPaperCustom  7 0.2 (if model.dependence then green else red),
                    text (Debug.toString <| truncate <| (Tuple.first (secondValFromList (model.polyState1))))
                        |> filled black 
                        |> move (-82, 40),
                    text ("[")
                      |> filled black
                      |> scaleY 2
                      |> move (-90,33),        
                    text (Debug.toString <| truncate <| (Tuple.second (secondValFromList (model.polyState1))))
                        |> filled black 
                        |> move (-82, 30),
                    text ("]")
                      |> filled black
                      |> scaleY 2
                      |> move (-68,33),          
                    text (Debug.toString <| truncate <| (Tuple.first (secondValFromList (model.polyState2))))
                        |> filled black 
                        |> move (-51, 40),
                    text ("[")
                      |> filled black
                      |> scaleY 2
                      |> move (-60,33),          
                    text (Debug.toString <| truncate <| (Tuple.second (secondValFromList (model.polyState2))))
                        |> filled black 
                        |> move (-51, 30),
                    text ("]")
                      |> filled black
                      |> scaleY 2
                      |> move (-37,33),                   
                    square 200
                      |> ghost 
                      |> notifyMouseMoveAt Position1
                      |> notifyMouseMoveAt Position2,
                   group[ openPolygon (model.polyState1)
                      |> outlined (solid 1) black,
                   (model.shape1)
                      |> rotate (Tuple.second(toPolar (secondValFromList model.polyState1)))
                      |> move (secondValFromList (model.polyState1))
                      |> notifyTap FlipState1
                      |> notifyTap FlipArrow1
                      ],
                   group[ openPolygon (model.polyState2)
                      |> outlined (solid 1) red,
                   (model.shape2)
                      |> rotate (Tuple.second(toPolar (secondValFromList model.polyState2)))
                      |> move (secondValFromList (model.polyState2))
                      |> notifyTap FlipState2
                      |> notifyTap FlipArrow2                      
                      ],    
                 if model.dependence
                   then 
                     group [ rect 70 15
                             |> filled yellow
                             |> makeTransparent 0.3
                             |> move (61,44),
                             text "Independent!"
                             |> filled darkGreen
                             |> move (30, 40) ]
                   else
                     group [ rect 70 15
                             |> filled yellow
                             |> makeTransparent 0.3
                             |> move (57,44),
                             text "Dependent!"
                             |> filled red
                             |> move (30,40) ]
            , group [ rect 200 15
                      |> filled yellow
                      |> makeTransparent 0.3
                      |> move (0,-62.5),
                      text "Click and drag the arrows around to change the vectors"
                      |> filled darkBlue
                      |> scale 0.7
                      |> move (-95,-62) ]
            , group [ transitionButton Right LinVisBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (0,-50)
                      |> notifyTap LinVisBack
            , group [ transitionButton Right BacktoLinV
                      |> scale 0.7
                      |> move (30, -5)
                    , text "QUIT"
                      |> filled white
                      |> scale 0.4
                      |> move (65,9)
                    ] |> move (0,-40)
                      |> notifyTap BacktoLinV
            ]
        LinQuiz  ->
            [ (html 100000 10000 <| Html.img [Html.Attributes.src tech] [] )
                      |> scale 0.225
                      |> move (-102,70)
            , group[question |> move(-5,-5)
                  ,text "Linear Independence Quiz"
                     |> size 13
                     |> centered
                     |> filled white
                     |> move (0,45)
                  
                   , group[
                       button
                         |> scaleX 1.5
                      ,text "Linearly dependent"
                        |> size 8
                        |> filled white
                        |> move(-30,-2)
                       ]|> move (-45,-10)
                        |> notifyTap ToFail
                   , group[
                       button
                         |> scaleX 1.5
                      ,text "Linearly Independent"
                        |> size 8
                        |> filled white
                        |> move(-34,-2)
                       ]|> move (45,-10)
                        |> notifyTap ToPass
                 ]
            , group [ transitionButton Right LinQuizBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-10,-45)
                      |> notifyTap LinQuizBack
            , group [ transitionButton Right BacktoLinQ
                      |> scale 0.7
                      |> move (30, -5)
                    , text "QUIT"
                      |> filled white
                      |> scale 0.4
                      |> move (65,9)
                    ] |> move (-10,-38)
                      |> notifyTap BacktoLinQ
            ]
        Fail  ->
            [
              square 200
              |> filled brown
              |> makeTransparent 0.2
            , (html 100000 10000 <| Html.img [Html.Attributes.src fail] [] )
                      |> scale 0.25
                      |> move (-55,40)
            , text "FAIL!"
                  |> centered
                  |> filled red
                  |> scale 1.5
                  |> move (0,45)
            , group[
                       button
                         |> scaleX 1.5
                      ,text "BACK"
                        |> size 8
                        |> filled white
                        |> move (-10,-2)
                       ]|> move (0,-40)
                        |> notifyTap BackFail   
            ]
        Pass  ->
            [
            (html 100000 10000 <| Html.img [Html.Attributes.src good] [] )
                      |> scale 0.45
                      |> move (-90,70)
                      
            , text "PASS!"
                  |> centered
                  |> filled green
                  |> scale 1.5
         
            , group[
                       button
                         |> scaleX 1.5
                      ,text "BACK"
                        |> size 8
                        |> filled white
                        |> move (-10,-2)
                       ]|> move (0,-30)
                        |> notifyTap BackPass  
            ]
        --Spans
        Span  ->
            [(html 100000 10000 <| Html.img [Html.Attributes.src linIndep_background] [] )
                  |> scale 0.45
                  |> move (-100,65)
            ,text "SPAN"
                  |> centered
                  |> filled black
                  |> move (0,45)
            , definitionSpan
            ,( html 100000 10000 <| Html.img [Html.Attributes.src span_gif] [] )
                  |> scale 0.16
                  |> move (11,28)
            , group [ transitionButton Right ToSpanVis
                      |> scale 0.7
                      |> move (30, -10)
                    , text "VISUALIZATION"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-130,-48)
                      |> notifyTap ToSpanVis       
            , group [ transitionButton Right ToSpanQuiz
                      |> scale 0.7
                      |> move (30, -10)
                    , text "QUIZ"
                      |> filled white
                      |> scale 0.4
                      |> move (67,4)
                    ] |> move (-10,-48)
                      |> notifyTap ToSpanQuiz
            , group [ transitionButton Right SpanBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-70,-48)
                      |> notifyTap SpanBack
            ]
        SpanVis  ->
            [ graphPaperCustom  7 0.2 (if model.dependence then green else red),
                    if model.dependence
                     then 
                       group [ square 200
                             |> filled brown
                             |> makeTransparent 0.3,
                         group[ openPolygon (model.polyState1)
                             |> outlined (solid 1) purple
                             |> move (secondValFromList (model.polyState2)),                 
                            openPolygon (model.polyState2)
                             |> outlined (solid 1) purple
                             |> move (secondValFromList (model.polyState1)),
                            openPolygon [(0,0),(coordforSpan1 model,coordforSpan2 model)]
                             |> outlined (solid 1) black] ]
                    else
                        group   [ openPolygon (model.polyState1)
                                   |> outlined (solid 1) brown
                                   |> move (secondValFromList (model.polyState1))
                                   |> makeTransparent 0.7,                 
                                   openPolygon (model.polyState2)
                                   |> outlined (solid 1) brown
                                   |> move (secondValFromList (model.polyState2))
                                   |> makeTransparent 0.7
                                ],
                    group [ rect 200 10
                            |> filled yellow
                            |> makeTransparent 0.3
                            |> move (0,-60), 
                            text "Click and drag arrows around to change the vectors and see span  (a = 1, b = 1)"
                            |> filled darkBlue
                            |> scale 0.5
                            |> move (-94,-61.5) ],
                    group [ rect 100 9
                            |> filled yellow
                            |> makeTransparent 0.3
                            |> move (0,59),
                            text "Highlighted region shows span"
                            |> filled red
                            |> scale 0.6
                            |> move (-45,57) ],
                    text (Debug.toString <| truncate <| (Tuple.first (secondValFromList (model.polyState1))))
                        |> filled black 
                        |> move (-82, 40),
                    text ("[")
                      |> filled black
                      |> scaleY 2
                      |> move (-90,33),        
                    text (Debug.toString <| truncate <| (Tuple.second (secondValFromList (model.polyState1))))
                        |> filled black 
                        |> move (-82, 30),
                    text ("]")
                      |> filled black
                      |> scaleY 2
                      |> move (-68,33),          
                    text (Debug.toString <| truncate <| (Tuple.first (secondValFromList (model.polyState2))))
                        |> filled black 
                        |> move (-51, 40),
                    text ("[")
                      |> filled black
                      |> scaleY 2
                      |> move (-60,33),          
                    text (Debug.toString <| truncate <| (Tuple.second (secondValFromList (model.polyState2))))
                        |> filled black 
                        |> move (-51, 30),
                    text ("]")
                      |> filled black
                      |> scaleY 2
                      |> move (-37,33),                   
                    square 200
                      |> ghost 
                      |> notifyMouseMoveAt Position1
                      |> notifyMouseMoveAt Position2,
                   group[ openPolygon (model.polyState1)
                      |> outlined (solid 1) blue,
                   (model.shape3)
                      |> rotate (Tuple.second(toPolar (secondValFromList model.polyState1)))
                      |> move (secondValFromList (model.polyState1))
                      |> notifyTap FlipState1
                      |> notifyTap FlipArrow3
                      ],
                   group[ openPolygon (model.polyState2)
                      |> outlined (solid 1) red,
                   (model.shape2)
                      |> rotate (Tuple.second(toPolar (secondValFromList model.polyState2)))
                      |> move (secondValFromList (model.polyState2))
                      |> notifyTap FlipState2
                      |> notifyTap FlipArrow4                      
                      ]
            , group [ transitionButton Right SpanVisBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (0,-50)
                      |> notifyTap SpanVisBack
            , group [ transitionButton Right BacktoSpanV
                      |> scale 0.7
                      |> move (30, -5)
                    , text "QUIT"
                      |> filled white
                      |> scale 0.4
                      |> move (65,9)
                    ] |> move (0,-40)
                      |> notifyTap BacktoSpanV
            ]
        SpanQuiz  ->
            [ (html 100000 10000 <| Html.img [Html.Attributes.src tech] [] )
                      |> scale 0.225
                      |> move (-102,70)
            , group[ question2,
                    group[
                       button
                         |> scaleX 1.5
                      ,text "Yes, it spans"
                        |> size 8
                        |> filled white
                        |> move(-20,-2)
                       ]|> move (-45,-10)
                        |> notifyTap ToSpanFail
                   , group[
                       button
                         |> scaleX 1.5
                      ,text "No, it doesn't"
                        |> size 8
                        |> filled white
                        |> move(-20,-2)
                       ]|> move (45,-10)
                        |> notifyTap ToSpanPass
                 ]
            , group [ transitionButton Right SpanQuizBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-10,-45)
                      |> notifyTap SpanQuizBack
            , group [ transitionButton Right BackToSpanQ
                      |> scale 0.7
                      |> move (30, -5)
                    , text "QUIT"
                      |> filled white
                      |> scale 0.4
                      |> move (65,9)
                    ] |> move (-10,-38)
                      |> notifyTap BackToSpanQ 
            ]
        SpanPass  ->
            [ (html 100000 10000 <| Html.img [Html.Attributes.src good] [] )
                      |> scale 0.45
                      |> move (-90,70)
                      
            , text "PASS!"
                  |> centered
                  |> filled green
                  |> scale 1.5
         
            , group[
                       button
                         |> scaleX 1.5
                      ,text "BACK"
                        |> size 8
                        |> filled white
                        |> move (-10,-2)
                       ]|> move (0,-30)
                        |> notifyTap SpanPassBack  
            ]
        SpanFail  ->
            [ square 200
              |> filled brown
              |> makeTransparent 0.2
            , (html 100000 10000 <| Html.img [Html.Attributes.src fail] [] )
                      |> scale 0.25
                      |> move (-55,40)
            , text "FAIL!"
                  |> centered
                  |> filled red
                  |> scale 1.5
                  |> move (0,45)
            , group[
                       button
                         |> scaleX 1.5
                      ,text "BACK"
                        |> size 8
                        |> filled white
                        |> move (-10,-2)
                       ]|> move (0,-40)
                        |> notifyTap SpanFailBack 
            ] 

        Eig  ->
            [(html 100000 10000 <| Html.img [Html.Attributes.src linIndep_background] [] )
                      |> scale 0.45
                      |> move (-100,65)
             , text "EIGEN-VALUES/VECTORS"
                  |> centered
                  |> filled black
                  |> move (0,45)
            , definitionEig
            ,( html 100000 10000 <| Html.img [Html.Attributes.src eig_gif] [] )
                  |> scale 0.16
                  |> move (10,28)
             , group [ transitionButton Right ToEigVis
                      |> scale 0.7
                      |> move (30, -10)
                    , text "VISUALIZATION"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-130,-48)
                      |> notifyTap ToEigVis       
            , group [ transitionButton Right ToEigQuiz
                      |> scale 0.7
                      |> move (30, -10)
                    , text "QUIZ"
                      |> filled white
                      |> scale 0.4
                      |> move (67,4)
                    ] |> move (-10,-48)
                      |> notifyTap ToEigQuiz
            , group [ transitionButton Right EigBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-70,-48)
                      |> notifyTap EigBack
            ]
        -- Eigenavlues and Eigenvector
        EigVis  ->
            [group
              [
                   graphPaperCustom  6 0.1 (green),
                    rect 1 200
                      |> filled darkGrey
                      |> makeTransparent 0.8,
                    rect 200 1
                      |> filled darkGrey
                      |> makeTransparent 0.8
                    -- matrix starts here
                   ,group[
                      rect 43 25
                        |> filled white
                        |> move (-69,38),
                      text "matrix A"
                        |> size 6
                        |> filled black
                        |> move (-80,26),
                      text ("[")
                        |> centered
                        |> filled black
                        |> scaleY 2
                        |> move (-90,33),
                      text (Debug.toString <| truncate <| toFloat(round(Tuple.first (secondValFromList (model.polyState1)))))
                          |> size 10
                          |> centered
                          |> filled darkGreen 
                          |> move (-80, 42),        
                      text (Debug.toString <| truncate <| toFloat(round((Tuple.second (secondValFromList (model.polyState1))))))
                          |> size 10
                          |> centered
                          |> filled darkGreen
                          |> move (-80, 32),         
                      text (Debug.toString <| truncate <| toFloat(round((Tuple.first (secondValFromList (model.polyState2))))))
                          |> size 10
                          |> centered
                          |> filled red 
                          |> move (-64, 42),          
                      text (Debug.toString <| truncate <| toFloat(round((Tuple.second (secondValFromList (model.polyState2))))))
                          |> size 10
                          |> centered
                          |> filled red 
                          |> move (-64, 32),
                      text ("]")
                        |> centered
                        |> filled black
                        |> scaleY 2
                        |> move (-52,33)
                        ] |> move (0,10),
                   -- vector v 
                    group[
                      rect 16 26
                        |>filled white
                        |> move (-36,38),
                      text ("[")
                        |> filled black
                        |> scaleY 2
                        |> move (-45,33),
                      text (Debug.toString <| truncate <| toFloat(round((Tuple.first (secondValFromList (model.vectorState))))))
                        |> size 10
                        |> filled darkBlue 
                        |> move (-41, 42),          
                      text (Debug.toString <| truncate <| toFloat(round((Tuple.second (secondValFromList (model.vectorState))))))
                        |> size 10
                        |> filled darkBlue 
                        |> move (-41, 32),
                      text ("]")
                        |> filled black
                        |> scaleY 2
                        |> move (-31,33)
                     ,text "v"
                        |> size 8
                        |> filled black
                        |> move (-38, 25)
                          ] |> move (0,10),
                    --Av eigenvector values resulting from matrix 'A' * vector 'v'
                    group[
                     rect 18 26
                        |>filled white
                        |> move (-11,38)
                    ,text ("[")
                        |> filled black
                        |> scaleY 2
                        |> move (-21,33)   
                    ,text (Debug.toString <| truncate <| toFloat(round((Tuple.first ( vectorMult (secondValFromList (model.polyState1)) 
                                                                                  (secondValFromList (model.polyState2))  
                                                                                  (secondValFromList (model.vectorState))))))) 
                        |> centered
                        |> size 10
                        |> filled (rgb 139 103 148)
                        |> move (-11, 42)            
                    ,text (Debug.toString <| truncate <| toFloat(round((Tuple.second( vectorMult (secondValFromList (model.polyState1)) 
                                                                                  (secondValFromList (model.polyState2))  
                                                                                  (secondValFromList (model.vectorState))))))) 
                        |> centered
                        |> size 10
                        |> filled (rgb 139 103 148)
                        |> move (-11, 32)
                    ,text ("]")
                        |> filled black
                        |> scaleY 2
                        |> move (-4,33)
                   , text "Av"
                        |> size 8
                        |> filled black
                        |> move (-16, 25)
                        ]|> move (0,10)
                    ,square 200
                        |> ghost 
                        |> notifyMouseMoveAt Position1
                        |> notifyMouseMoveAt Position2
                        |> notifyMouseMoveAt VectorPos1
                    ,group[
                       group[ openPolygon (model.polyState1)
                          |> outlined (solid 1) green
                       ,(model.shape5)
                          |> rotate (Tuple.second(toPolar (secondValFromList model.polyState1)))
                          |> move (secondValFromList (model.polyState1))
                          |> notifyTap FlipState1
                          |> notifyTap FlipArrow5
                          |> notifyMouseMoveAt Repeat2 
                          ]
                       ,group[ openPolygon (model.polyState2)
                          |> outlined (solid 1) red
                       ,(model.shape2)
--                          |> rotate (degrees 180)
                          |> rotate (Tuple.second(toPolar (secondValFromList model.polyState2)))
                          |> move (secondValFromList (model.polyState2))                          
                          |> notifyTap FlipState2
                          |> notifyTap FlipArrow2  
                          |> notifyMouseMoveAt Repeat3                    
                          ] 
                      ,openPolygon  (model.vectorState)
                          |> outlined (dotted 1) blue 
                      ,vectorPoint
                        |> move (secondValFromList (model.vectorState))
                        |> notifyTap VectorTap1
                        |> notifyMouseMoveAt Repeat
                      ,vectorPoint2
                        |> move (firstTupleFromList (model.vectorState) )
                      ]  
                   -- display eigen values
                   ,group[
                     rect 25 20
                        |>filled white
                        |> move (12,40)
                    ,case (round(Tuple.first(eigenValues (secondValFromList (model.polyState1))
                                                                                (secondValFromList (model.polyState2))))
                        ,round(Tuple.second(eigenValues (secondValFromList (model.polyState1))
                                                                                (secondValFromList (model.polyState2)))))
                        of
                          (0,0) -> group[
                                    text "\u{03BB}= i"
                                      |> centered
                                      |> size 10
                                      |> filled darkOrange
                                      |> move (12, 42)
                                   ,text "\u{03BB} i"
                                      |> centered
                                      |> size 10
                                      |> filled darkOrange
                                      |> move (12, 32)
                                      ]
                          (x,y) -> group[
                                    text (("\u{03BB}= ") ++ (Debug.toString <| truncate <| toFloat(x)))
                                      |> centered
                                      |> size 10
                                      |> filled darkOrange
                                      |> move (12, 42)
                                   ,text (("\u{03BB}= ") ++ (Debug.toString <| truncate <| toFloat(y)))
                                      |> centered
                                      |> size 10
                                      |> filled darkOrange
                                      |> move (12, 32)
                                        ]
                       ]|> move (3,10)
                 -- eigen visulaization explination 
                 -- circle
                    ,group[
                      circle 6.5
                        |> filled black
                        |> move (85,-55)
                     ,circle 6
                        |> filled lightRed
                        |> move (85,-55)
                     ,text "?"
                        |> centered
                        |> filled white
                        |> move (85,-58.5)
                    ]|> notifyTap EigenExplainTap 
                 -- explination  
                 , case model.eigenExplain of
                     True ->
                       group[
                        rect 172 22
                           |> filled darkCharcoal
                           |> move (-8,-53) 
                           |> makeTransparent 0.95
                        ,group
                          [text "Let 'A' be a matrix with colums (as arrows) and 'v' (blue) be a vector . Multiplying A by v results in a"
                             |> centered
                             |> size 4.2
                             |> filled white
                             |> move (-8,-48)
                          ,text "new vector 'Av'(purple). The orange values are the eigenValues of the matrix A, "
                             |> centered
                             |> size 4.2
                             |> filled white
                             |> move (-8,-53)
                          ,text "Click and drag the red and green arrows to change the matrix and the blue circle to change vector V"
                             |> centered
                             |> size 4.2
                             |> filled white
                             |> move (-8,-60)
                           ] |> move (0,2)
                            ]|> move (0,1)
                     False ->
                       group []
                 ]
              , group [ transitionButton Right BacktoEigV
                      |> scale 0.7
                      |> move (30, -5)
                    , text "QUIT"
                      |> filled white
                      |> scale 0.4
                      |> move (65,9)
                    ] |> move (0,45)
                      |> notifyTap BacktoEigV
            , group [ transitionButton Right EigVisBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (0,35)
                      |> notifyTap EigVisBack
            ]
        EigQuiz  ->
            [ (html 100000 10000 <| Html.img [Html.Attributes.src tech] [] )
                      |> scale 0.225
                      |> move (-102,70),
              text "Eigenvalues & Eigenvectors Quiz"
                     |> size 11.5
                     |> centered
                     |> filled white
                     |> move (0,45)
            , group[question3 |>move(0,27)
                   , group[
                       button
                         |> scaleX 1.5
                      ,text "Option A"
                        |> size 8
                        |> filled white
                        |> move(-15,-2)
                       ]|> move (-45,-10)
                        |> notifyTap ToEigPass
                   , group[
                       button
                         |> scaleX 1.5
                      ,text "Option B"
                        |> size 8
                        |> filled white
                        |> move(-15,-2)
                       ]|> move (45,-10)
                        |> notifyTap ToEigFail

            ]
        
            , group [ transitionButton Right EigQuizBack
                      |> scale 0.7
                      |> move (30, -10)
                    , text "BACK TO MENU"
                      |> filled white
                      |> scale 0.4
                      |> move (54,4)
                    ] |> move (-10,-45)
                      |> notifyTap EigQuizBack
            , group [ transitionButton Right BacktoEigQ
                      |> scale 0.7
                      |> move (30, -5)
                    , text "QUIT"
                      |> filled white
                      |> scale 0.4
                      |> move (65,9)
                    ] |> move (-10,-38)
                      |> notifyTap BacktoEigQ 
            ]
        EigPass  ->
            [ (html 100000 10000 <| Html.img [Html.Attributes.src good] [] )
                      |> scale 0.45
                      |> move (-90,70)
                      
            , text "PASS!"
                  |> centered
                  |> filled green
                  |> scale 1.5
         
            , group[
                       button
                         |> scaleX 1.5
                      ,text "BACK"
                        |> size 8
                        |> filled white
                        |> move (-10,-2)
                       ]|> move (0,-30)
                        |> notifyTap EigPassBack 
            ]
        EigFail  ->
            [ square 200
              |> filled brown
              |> makeTransparent 0.2
            , (html 100000 10000 <| Html.img [Html.Attributes.src fail] [] )
                      |> scale 0.25
                      |> move (-55,40)
            , text "FAIL!"
                  |> centered
                  |> filled red
                  |> scale 1.5
                  |> move (0,45)
            , group[
                       button
                         |> scaleX 1.5
                      ,text "BACK"
                        |> size 8
                        |> filled white
                        |> move (-10,-2)
                       ]|> move (0,-40)
                        |> notifyTap EigFailBack 
            ] 

type Msg = Tick Float GetKeyState
         | ToLinInd
         | ToLinVis
         | ToLinQuiz
         | ToSpan
         | ToEig
         | LinVisBack
         | LinQuizBack
         | SpanBack
         | EigBack
         | BacktoLinV
         | BacktoLinQ
         | LinIndBack
         | ToFail
         | ToPass
         | BackFail
         | BackPass
         | ToSpanVis
         | BacktoSpanV
         | SpanVisBack
         | ToSpanQuiz
         | BackToSpanQ
         | ToSpanPass
         | ToSpanFail
         | SpanFailBack
         | SpanPassBack
         | ToEigVis
         | BacktoEigV
         | EigVisBack
         | ToEigQuiz
         | ToEigPass
         | ToEigFail
         | EigPassBack
         | EigFailBack
         | SpanQuizBack
         | BacktoEigQ
         | EigQuizBack
         | Position1 (Float, Float)
         | Position2 (Float, Float)           
         | FlipState1
         | FlipState2
         | FlipArrow1
         | FlipArrow2
         | FlipArrow3
         | FlipArrow4
         | FlipArrow5
         | VectorPos1 (Float, Float)
         | Repeat (Float,Float)
         | Repeat2 (Float,Float)
         | Repeat3 (Float,Float)
         | VectorTap1
         | EigenExplainTap --question mark explaining eigen visualizer                                     

type State = MainMenu 
           | LinInd 
           | LinVis 
           | LinQuiz  
           | Fail 
           | Pass 
           | Span 
           | Eig 
           | SpanVis 
           | SpanQuiz 
           | SpanPass 
           | SpanFail 
           | EigVis 
           | EigQuiz 
           | EigPass 
           | EigFail                       

update msg model =
    case msg of
        Tick t _ ->
            { model | time = t 
                     ,dependence = checkIndependence (formatVals(secondValFromList (model.polyState1))) (formatVals (secondValFromList (model.polyState2)))
                                  }
        ToLinInd ->
            case model.state of
                MainMenu  ->
                    { model | state = LinInd  }
                otherwise ->
                    model
        ToLinVis ->
            case model.state of
                LinInd  ->
                    { model | state = LinVis                           
                             ,polyState1 = [(0,0), (30,0)]
                             ,polyState2 = [(0,0), (-30,0)]
                             }
                otherwise ->
                    model
        ToLinQuiz ->
            case model.state of
                LinInd  ->
                    { model | state = LinQuiz  }
                otherwise ->
                    model
        ToSpan ->
            case model.state of
                MainMenu  ->
                    { model | state = Span  }
                otherwise ->
                    model
        ToEig ->
            case model.state of
                MainMenu  ->
                    { model | state = Eig  }
                otherwise ->
                    model

        LinVisBack ->
            case model.state of
                LinVis  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        LinQuizBack ->
            case model.state of
                LinQuiz  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        SpanBack ->
            case model.state of
                Span  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        EigBack ->
            case model.state of
                Eig  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        BacktoLinV ->
            case model.state of
                LinVis  ->
                    { model | state = LinInd  }
                otherwise ->
                    model
        BacktoLinQ ->
            case model.state of
                LinQuiz  ->
                    { model | state = LinInd  }
                otherwise ->
                    model
        LinIndBack ->
            case model.state of
                LinInd  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model    
        ToFail ->
            case model.state of
                LinQuiz  ->
                    { model | state = Fail  }
                otherwise ->
                    model
        ToPass ->
            case model.state of
                LinQuiz  ->
                    { model | state = Pass  }
                otherwise ->
                    model
        BackFail ->
            case model.state of
                Fail  ->
                    { model | state = LinInd  }
                otherwise ->
                    model
        BackPass ->
            case model.state of
                Pass  ->
                    { model | state = LinInd  }
                otherwise ->
                    model
        ToSpanVis ->
            case model.state of
                Span  ->
                    { model | state = SpanVis 
                             ,polyState1 = [(0,0), (30,0)]
                             ,polyState2 = [(0,0), (-30,0)]  
                             }
                otherwise ->
                    model
        BacktoSpanV ->
            case model.state of
                SpanVis  ->
                    { model | state = Span  }
                otherwise ->
                    model
        SpanVisBack ->
            case model.state of
                SpanVis  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        ToSpanQuiz ->
            case model.state of
                Span  ->
                    { model | state = SpanQuiz  }
                otherwise ->
                    model
        BackToSpanQ ->
            case model.state of
                SpanQuiz  ->
                    { model | state = Span  }
                otherwise ->
                    model
        ToSpanPass ->
            case model.state of
                SpanQuiz  ->
                    { model | state = SpanPass  }
                otherwise ->
                    model
        ToSpanFail ->
            case model.state of
                SpanQuiz  ->
                    { model | state = SpanFail  }
                otherwise ->
                    model
        SpanFailBack ->
            case model.state of
                SpanFail  ->
                    { model | state = Span  }
                otherwise ->
                    model
        SpanPassBack ->
            case model.state of
                SpanPass  ->
                    { model | state = Span  }
                otherwise ->
                    model
        ToEigVis ->
            case model.state of
                Eig  ->
                    { model | state = EigVis                         
                             ,polyState1 = [(0,0), (30,0)]
                             ,polyState2 = [(0,0), (-30,0)]
                             ,vectorState = [(0,0),(10,10)] 
                             }
                otherwise ->
                    model
        BacktoEigV ->
            case model.state of
                EigVis  ->
                    { model | state = Eig  }
                otherwise ->
                    model
        EigVisBack ->
            case model.state of
                EigVis  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        ToEigQuiz ->
            case model.state of
                Eig  ->
                    { model | state = EigQuiz  }
                otherwise ->
                    model
        ToEigPass ->
            case model.state of
                EigQuiz  ->
                    { model | state = EigPass  }
                otherwise ->
                    model
        ToEigFail ->
            case model.state of
                EigQuiz  ->
                    { model | state = EigFail  }
                otherwise ->
                    model
        EigPassBack ->
            case model.state of
                EigPass  ->
                    { model | state = Eig  }
                otherwise ->
                    model
        EigFailBack ->
            case model.state of
                EigFail  ->
                    { model | state = Eig  }
                otherwise ->
                    model
        SpanQuizBack ->
            case model.state of
                SpanQuiz  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        BacktoEigQ ->
            case model.state of
                EigQuiz  ->
                    { model | state = Eig  }
                otherwise ->
                    model
        EigQuizBack ->
            case model.state of
                EigQuiz  ->
                    { model | state = MainMenu  }
                otherwise ->
                    model
        Position1 (x,y) -> {model| polyState1 = case model.dragState1 of 
                                                 Released -> model.polyState1
                                                 Dragging -> [(0,0), (x,y)]
                                   }
        Position2 (x,y) -> {model| polyState2 = case model.dragState2 of 
                                                 Released -> model.polyState2
                                                 Dragging -> [(0,0), (x,y)]  
                                   }
        VectorPos1 (x,y) -> {model| vectorState = case model.dragVector1 of 
                                                 Released -> model.vectorState
                                                 Dragging -> [(0,0), (x,y)] 
                                   } 
                                         
        -- repeats purpose is to reposition the Av circle, The product of vector and 
        -- matrix multiplication: [ green red ] * [blue dot]
        Repeat (x,y) -> {model | vectorState =  case model.dragVector1 of 
                                                 Released -> model.vectorState
                                                 Dragging ->
                                                             [( vectorMult (secondValFromList (model.polyState1)) 
                                                              (secondValFromList (model.polyState2))  
                                                              (secondValFromList (model.vectorState))) 
                                                              , (x,y)]
                                   }
        Repeat2 _ -> {model| vectorState = case model.dragState1 of 
                                                 Released -> model.vectorState
                                                 Dragging -> 
                                                             [( vectorMult (secondValFromList (model.polyState1)) 
                                                              (secondValFromList (model.polyState2))  
                                                              (secondValFromList (model.vectorState))) 
                                                              , secondValFromList (model.vectorState)]
                                   }
        Repeat3 _ -> {model| vectorState = case model.dragState2 of 
                                                 Released -> model.vectorState
                                                 Dragging -> 
                                                             [( vectorMult (secondValFromList (model.polyState1)) 
                                                              (secondValFromList (model.polyState2))  
                                                              (secondValFromList (model.vectorState))) 
                                                              , secondValFromList (model.vectorState)]
                                   }
        FlipState1 -> {model | dragState1 = case model.dragState1 of 
                                               Released -> Dragging 
                                               Dragging -> Released 
                                   }  
        FlipState2 -> {model | dragState2 = case model.dragState2 of 
                                               Released -> Dragging 
                                               Dragging -> Released 
                                   }
        VectorTap1 -> {model | dragVector1 = case model.dragVector1 of 
                                               Released -> Dragging 
                                               Dragging -> Released 
                                   }
        FlipArrow1 -> {model | shape1 = case model.dragState1 of 
                                               Released -> initShape1
                                               Dragging -> onPressShape1
                                   }  
        FlipArrow2 -> {model | shape2 = case model.dragState2 of 
                                               Released -> initShape2
                                               Dragging -> onPressShape1                                              
                                   }   
        FlipArrow3 -> {model | shape3 = case model.dragState1 of 
                                               Released -> initShape3
                                               Dragging -> onPressShape2
                                   }  
        FlipArrow4 -> {model | shape2 = case model.dragState2 of 
                                               Released -> initShape4
                                               Dragging -> onPressShape2                                               
                                   }  
        FlipArrow5 -> {model | shape5 = case model.dragState1 of 
                                               Released -> initShape5
                                               Dragging -> onPressShape1                                               
                                   }      
        EigenExplainTap -> {model | eigenExplain = case model.eigenExplain of 
                                               True  -> False
                                               False -> True
                                   }    
                                
                                                                                                                              
       
type ButtonPosition = Left | Right | Middle

transitionButton : ButtonPosition -> Msg -> Shape Msg
transitionButton pos msg = case pos of 
      Left   -> group [ roundedRect 60 15 2 
                        |> filled black
                      , roundedRect 58 13 2
                        |>filled black
                      ] |> move (-60, 22)
                        |> notifyTap msg
                       
      Right  -> group [roundedRect 60 15 2 
                        |> filled black
                       ,roundedRect 58 13 2
                         |>filled black
                      ] |> move (60, 22)
                        |> notifyTap msg
      Middle -> group [roundedRect 60 15 2 
                        |> filled black
                       ,roundedRect 58 13 2
                         |>filled black
                      ] |> move (0, 22)
                        |> notifyTap msg 
     
button = group [
           roundedRect 50 16 4
               |> filled black
        
               ]
question = group[
              group[
                text "Are V1 =        and V2 =           "
                      |>size 6
                      |>filled black
                      |> move(-85,20)
               ,text "["
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-62,20)
               ,text "["
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-27,20)
                ,text "1"
                 |>size 6
                 |>filled black
                 |> move(-58,23)
                ,text "0"
                 |>size 6
                 |>filled black
                 |> move(-58,17)
                 ,text "0"
                 |>size 6
                 |>filled black
                 |> move(-20,23)
                ,text "2020"
                 |>size 5.5
                 |>filled black
                 |> move(-24,17)
                ,text "]"
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-53,20)
                ,text "]"
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-13,20)
                ]|>move (45,10)
                ,text "linearly dependent or linearly independent?"
                      |>size 6
                      |>filled black
                      |> move(-55,15)
                ]
question2= group[ text "Span Quiz"
                     |> size 12.5
                     |> centered
                     |> filled white
                     |> move (0,46)
             ,group[
                text "     V1 =              and V2 =           "
                      |>size 6
                      |>filled black
                      |> move(-85,20)
               ,text "["
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-62,20)
               ,text "["
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-20,20)
                ,text "1"
                 |>size 6
                 |>filled black
                 |> move(-58,23)
                ,text "-2"
                 |>size 6
                 |>filled black
                 |> move(-58,17)
                 ,text "-2"
                 |>size 6
                 |>filled black
                 |> move(-17,23)
                ,text "4"
                 |>size 5.5
                 |>filled black
                 |> move(-16,17)
                ,text "]"
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-50,20)
                ,text "]"
                 |>size 7
                 |>filled black
                 |>scaleY 1.5
                 |> move(-10,20)
                ]|>move (45,10)
                   , text "Does {V1,V2} span R  ?"
                     |> centered
                     |> size 8
                     |> filled black
                     |> move(0,16.5)
                   
                   , text "2"
                     |> size 5
                     |> filled black
                     |> move (32.5,21.5)
                   
                   
                   
                    ]
                    

question3=group[text"Which is eigenvalue and eigenvector of A=           "
                  |> centered
                  |> size 7
                  |> filled black
               , text "[        ]"   
                  |> size 7
                  |> filled black
                  |> scaleY 2
                  |> move (52,0)
               , text " 2  7 "
                 |> size 7
                 |> filled black
                 |> move (53.5,7)
               , text " 7  2 "
                 |> size 7
                 |> filled black
                 |> move (53.5,-2)
                 
               , text "A. eigenvalues: 9  eigenvector[1 1] "
                 |> centered
                 |> size 7
                 |> filled black
                 |> move (0,-10)
               , text "B. eigenvalues: -7  eigenvector[-1 -1] "
                 |> centered
                 |> size 7
                 |> filled black
                 |> move (0,-20)
                 
                 
                 ]
                    
                    
definition = group[
                text "A set of vectors {v1,v2,...,vk} is linearly "
                      |>size 5
                      |>filled black
                      |> move(0,30)
               ,text "independent if and only if the vector equation"
                      |>size 5
                      |>filled black
                      |> move (0,24)
               ,text "x1v1+x2v2+···+xkvk=0"
                      |>size 5
                      |>filled black
                      |> move (22,16)
               ,text "has only the trivial solution, if and only if "
                      |>size 5
                      |>filled black
                      |> move (0,9)
               ,text "the matrix equation Ax=0 has only the "
                      |>size 5
                      |>filled black
                      |> move (0,2)
               ,text "trivial solution, where A is the matrix with "
                      |>size 5
                      |>filled black
                      |> move (0,-5)
               ,text "columns v1,v2,...,vk."
                      |>size 5
                      |>filled black
                      |> move (0,-12)
               ,text "This is true if and only if A has a pivot "
                      |>size 5
                      |>filled black
                      |> move (0,-19)
               ,text "position in every column. "
                      |>size 5
                      |>filled black
                      |> move (0,-26)
                  ]|>move (-90,0)
                  
definitionSpan = group[
                text "Let v\u{2081}, v\u{2082},...,v\u{2096} be vectors in R\u{207F}."
                      |>size 5
                      |>filled black
                      |> move(0,30)
               ,text "The span of v\u{2081}, v\u{2082},...,v\u{2096} is the collection of    "
                      |>size 5
                      |>filled black
                      |> move (0,23)
               ,text "all linear combinations of v\u{2081}, v\u{2082},...,v\u{2096}"
                      |>size 5
                      |>filled black
                      |> move (0,16)
               ,text "denoted Span{v\u{2081}, v\u{2082},...,v\u{2096}}. "
                      |>size 5
                      |>filled black
                      |> move (0,9)
               ,text "It can be said that Span{v\u{2081}, v\u{2082},...,v\u{2096}} is the subset"
                      |>size 5
                      |>filled black
                      |> move (0,2)
               ,text "spanned by the vectors {v\u{2081}, v\u{2082},...,v\u{2096}}"
                      |>size 5
                      |>filled black
                      |> move (0,-5)
                  ]|>move (-90,-10)

definitionEig = group[
                text "An eigenvector of A is a nonzero vector v in"
                      |>size 5
                      |>filled black
                      |> move(0,30)
               ,text "R\u{207F} such that Av = \u{03BB}v, for some scalar \u{03BB}. "
                      |>size 5
                      |>filled black
                      |> move (0,24)
               ,text "An eigenvalue of A is a scalar \u{03BB} such that"
                      |>size 5
                      |>filled black
                      |> move (0,16)
               ,text "equation Av=\u{03BB}v is a nontrivial solution. "
                      |>size 5
                      |>filled black
                      |> move (0,9)
               ,text "Note: Eigenvectors/values are only for square"
                      |>size 5
                      |>filled black
                      |> move (0,2)
               ,text "         matricies."
                      |>size 5
                      |>filled black
                      |> move (0,-5)
               ,text "         Eigenvectors by definition are non-zero "
                      |>size 5
                      |>filled black
                      |> move (0,-12)
                  ]|>move (-90,-10)
                  



                       
secondValFromList list = case List.head (case (List.tail list) of
                                                   Just x -> x 
                                                   Nothing -> [(-1,-1)]) of 
                                  Just x -> x
                                  Nothing -> (-1,-1)

firstTupleFromList list = case list of
                              (a,b)::xs -> (a,b)
                              _ -> (0,0)
                              
coordforSpan1 model =  Tuple.first (secondValFromList (model.polyState1))+Tuple.first (secondValFromList (model.polyState2))

coordforSpan2 model =  Tuple.second (secondValFromList (model.polyState1))+Tuple.second (secondValFromList (model.polyState2))

formatVals x = Tuple.mapBoth truncate truncate x

checkIndependence f g = ((Tuple.first(f) * Tuple.second(g)) - (Tuple.second(f)*Tuple.first(g))) /= 0 


-- checkWin: Model -> Shape Msg
checkWin model = if model.gameState == List.repeat 9 False
                 then text "LIGHTS OUT (:"
                        |> centered
                        |> sansserif
                        |> filled white
                        |> move (-100, 40)
                 else text "LIGHTS ON ):" 
                        |> sansserif
                        |> filled white
                        |> move (-35, 40)                 

--eigenvalue begins

--use quadratic theorem to get the eigen values
eigenValues g f= 
        let
          --elements of the matrix
          a1x = toFloat(round(Tuple.first  (g)))
          a1y = toFloat(round(Tuple.second (g)))
          a2x = toFloat(round(Tuple.first  (f)))
          a2y = toFloat(round(Tuple.second (f)))
          --values to be used in quadratic formula
          a = 1
          b = a1x + a2y
          c = (a1x * a2y) - (a1y * a2x)
          -- apply x and y values
          x = (b + sqrt(b^2 - (4*a*c))) / (2 * a)
          y = (b - sqrt(b^2 - (4*a*c))) / (2 * a)
        in
          (x,y)
          
--movable vector circle
vectorPoint = circle 3
                |> filled darkBlue 

-- circle of resulting vector from matrix and vector multiplication
vectorPoint2= circle 3
                |> filled (rgb 139 103 148)

--vector matrix multiplication
vectorMult g f h = 
            let
              a1x = toFloat(round(Tuple.first  (g)))
              a1y = toFloat(round(Tuple.second (g)))
              a2x = toFloat(round(Tuple.first  (f)))
              a2y = toFloat(round(Tuple.second (f)))
              vx  = toFloat(round(Tuple.first  (h)))
              vy  = toFloat(round(Tuple.second (h)))
              x   = ((a1x * vx)+(a2x * vy))  --subtracting starting position
              y   = ((a1y * vx)+(a2y * vy)) --subtracting starting position
            in
              (x,y)

type DragState = Released | Dragging                                      
           
onPressShape1 = circle 3
                |> filled (rgb  20 125 50)  
onPressShape2 = circle 3
                |> filled black               
onPressShape3 = circle 3
                |> filled green    
initShape1 = triangle 3
              |> filled black
initShape2 = triangle 3
              |> filled red
initShape3 = triangle 3
              |> filled blue
initShape4 = triangle 3
              |> filled red     
initShape5 = triangle 3
              |> filled green 


type alias Model =
    { time : Float
    , state : State                         
    , polyState1 : List ( Float,Float)
    , polyState2 : List ( Float,Float)
    , dragState1 : DragState
    , dragState2 : DragState
    , dependence : Bool
    , gameState : List Bool
    }
    

init = { time = 0 
       , state = MainMenu                         
       , polyState1 = [(0,0), (30,0)]
       , polyState2 = [(0,0), (-30,0)]
       , vectorState = [(0,0),(10,10)]
       , dragState1 = Released
       , dragState2 = Released
       , dragVector1 = Released
       , shape1 = initShape1
       , shape2 = initShape2
       , shape3 = initShape3
       , shape4 = initShape4
       , shape5 = initShape5
       , dependence = False 
       , eigenExplain = False
       , gameState = List.repeat 9 True
       }



