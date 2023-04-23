module Icons exposing (elmLogo)

import Svg exposing (svg)
import Svg.Attributes as SvgAttr


elmLogo =
    svg
        [ SvgAttr.viewBox "-300 -300 600 600"
        ]
        [ Svg.g
            [ SvgAttr.transform "scale(1 -1)"
            ]
            [ Svg.polygon
                [ SvgAttr.fill "rgba(18, 147, 216, 1)"
                , SvgAttr.points "-280,-90 0,190 280,-90"
                , SvgAttr.transform "translate(0 -210) rotate(0)"
                ]
                []
            , Svg.polygon
                [ SvgAttr.fill "rgba(18, 147, 216, 1)"
                , SvgAttr.points "-280,-90 0,190 280,-90"
                , SvgAttr.transform "translate(-210 0) rotate(-90)"
                ]
                []
            , Svg.polygon
                [ SvgAttr.fill "rgba(18, 147, 216, 0.75)"
                , SvgAttr.points "-198,-66 0,132 198,-66"
                , SvgAttr.transform "translate(207 207) rotate(-45)"
                ]
                []
            , Svg.polygon
                [ SvgAttr.fill "rgba(18, 147, 216, 1)"
                , SvgAttr.points "-130,0 0,-130 130,0 0,130"
                , SvgAttr.transform "translate(150 0) rotate(0)"
                ]
                []
            , Svg.polygon
                [ SvgAttr.fill "rgba(18, 147, 216, 0.75)"
                , SvgAttr.points "-191,61 69,61 191,-61 -69,-61"
                , SvgAttr.transform "translate(-89 239) rotate(0)"
                ]
                []
            , Svg.polygon
                [ SvgAttr.fill "rgba(18, 147, 216, 0.75)"
                , SvgAttr.points "-130,-44 0,86  130,-44"
                , SvgAttr.transform "translate(0 106) rotate(-180)"
                ]
                []
            , Svg.polygon
                [ SvgAttr.fill "rgba(18, 147, 216, 0.75)"
                , SvgAttr.points "-130,-44 0,86  130,-44"
                , SvgAttr.transform "translate(256 -150) rotate(-270)"
                ]
                []
            ]
        ]
