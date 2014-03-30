({
    baseUrl: ".",
    paths: {
        jquery:     "libs/jquery",
        underscore: "libs/underscore",
        backbone:   "libs/backbone",
        text:       "libs/text",
        v_stats_app:  "views/v_stats_app"

    },

    out: "_build/app_stats_build.js",

    include: ["app","v_stats_app"],
    wrap: true,
    /*
    modules: [ {  //name: "v_mApp" "app" }],
    */
    mainConfigFile: 'app.js',
    preserveLicenseComments: false,
  
})