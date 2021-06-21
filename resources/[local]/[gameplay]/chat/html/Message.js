Vue.component('message', {
  template: '#message_template',
  data() {
    return {};
  },
  computed: {
    textEscaped() {
      let s = this.template ? this.template : this.templates[this.templateId];

      if (this.template) {
        //We disable templateId since we are using a direct raw template
        this.templateId = -1;
      }

      //This hack is required to preserve backwards compatability
      if (this.templateId == CONFIG.defaultTemplateId
          && this.args.length == 1) {
        s = this.templates[CONFIG.defaultAltTemplateId] //Swap out default template :/
      }

      s = s.replace(/{(\d+)}/g, (match, number) => {
        const argEscaped = this.args[number] != undefined ? this.escape(this.args[number]) : match
        if (number == 0 && this.color) {
          //color is deprecated, use templates or ^1 etc.
          return this.colorizeOld(argEscaped);
        }
        return argEscaped;
      });
      return this.colorize(s);
    },
  },
  methods: {
    colorizeOld(str) {
      return `<span style="color: rgb(${this.color[0]}, ${this.color[1]}, ${this.color[2]})">${str}</span>`
    },
    colorize(str) {
      let s = "<span>" + (str.replace(/\^([0-9])/g, (str, color) => `</span><span class="color-${color}">`)) + "</span>";
	  

	  //console.log(s.replace(":1:", "<img src='https://cdn.discordapp.com/emojis/619977221951586320.png?v=1'></img>"));

      const styleDict = {
        '*': 'font-weight: bold;',
        '_': 'text-decoration: underline;',
        '~': 'text-decoration: line-through;',
        '=': 'text-decoration: underline line-through;',
        'r': 'text-decoration: none;font-weight: normal;',
      };

      const styleRegex = /\^(\_|\*|\=|\~|\/|r)(.*?)(?=$|\^r|<\/em>)/;
      while (s.match(styleRegex)) { //Any better solution would be appreciated :P
        s = s.replace(styleRegex, (str, style, inner) => `<em style="${styleDict[style]}">${inner}</em>`)
      }
      var s1 = s.replace(/<span[^>]*><\/span[^>]*>/g, '');
	  var s2 = test1(s1);
	  
	  return s2;
    },
    escape(unsafe) {
      return String(unsafe)
       .replace(/&/g, '&amp;')
       .replace(/</g, '&lt;')
       .replace(/>/g, '&gt;')
       .replace(/"/g, '&quot;')
       .replace(/'/g, '&#039;');
    },
  },
  props: {
    templates: {
      type: Object,
    },
    args: {
      type: Array,
    },
    template: {
      type: String,
      default: null,
    },
    templateId: {
      type: String,
      default: CONFIG.defaultTemplateId,
    },
    multiline: {
      type: Boolean,
      default: false,
    },
    color: { //deprecated
      type: Array,
      default: false,
    },
  },
});


function test1(text) {
	
	var emojRange = [
    ["\:1:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/686270467056992314.png?v=1\"></img>"],
    ["\:2:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/619977221951586320.png?v=1\"></img>"], 
    ["\:3:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/619493231599681547.png?v=1\"></img>"], 
    ["\:4:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/619975400377942036.png?v=1\"></img>"], 
    ["\:5:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/619977214330535965.png?v=1\"></img>"], 
    ["\:6:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/691581782570565633.png?v=1\"></img>"], 
    ["\:cac:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/649728797075177505.png?v=1\"></img>"], 
    ["\:7:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/653684058592641036.gif?v=1\"></img>"], 
    ["\:8:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/650045493442772992.gif?v=1\"></img>"], 
    ["\:9:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/650050799027879967.gif?v=1\"></img>"], 
    ["\:10:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/650045492885061679.gif?v=1\"></img>"], 
    ["\:11:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/650050802408488978.gif?v=1\"></img>"], 
    ["\:12:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/653875017251160064.gif?v=1\"></img>"], 
    ["\:13:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/650052291973349376.gif?v=1\"></img>"], 
    ["\:14:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/650045493052702742.gif?v=1\"></img>"], 
    ["\:15:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/629691136449052682.gif?v=1\"></img>"], 
    ["\:16:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/629556806712295435.gif?v=1\"></img>"], 
    ["\:17:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/650050800311074874.gif?v=1\"></img>"], 
    ["\:18:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/651090673709350912.gif?v=1\"></img>"], 
    ["\:19:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/629580308731133952.gif?v=1\"></img>"], 
    ["\:20:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/629576649599352853.gif?v=1\"></img>"], 
    ["\:21:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/674791079001849856.gif?v=1\"></img>"], 
    ["\:22:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809237102478098442.gif?v=1\"></img>"],
    ["\:23:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823943891746846.gif?v=1\"></img>"],
    ["\:24:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823948627378206.gif?v=1\"></img>"],
    ["\:25:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823945523068938.gif?v=1\"></img>"],
    ["\:26:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823943804059658.gif?v=1\"></img>"],
    ["\:27:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809826421060927508.png?v=1\"></img>"],
    ["\:28:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823946169384971.gif?v=1\"></img>"],
    ["\:29:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823943371259944.gif?v=1\"></img>"],
    ["\:30:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809826420074479657.png?v=1\"></img>"],
    ["\:31:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809826421060927508.png?v=1\"></img>"],
    ["\:32:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823946169384971.gif?v=1\"></img>"],
    ["\:33:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809823943371259944.gif?v=1\"></img>"],
    ["\:34:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/809826420074479657.png?v=1\"></img>"],
    ["\:35:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/773749193298280509.gif?v=1\"></img>"],
    ["\:36:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/773622545239769119.gif?v=1\"></img>"],
    ["\:37:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/773622545239769119.gif?v=1\"></img>"],
    ["\:38:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/775073660363997195.gif?v=1\"></img>"],
    ["\:39:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/773749224973008896.gif?v=1\"></img>"],
    ["\:40:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/773750554702118912.gif?v=1\"></img>"],
    ["\:41:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/662972416661782528.gif?v=1\"></img>"],
    ["\:42:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/805402971902705735.gif?v=1\"></img>"],
    ["\:43:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/663731436892717067.gif?v=1\"></img>"],
    ["\:44:", "<img class=\"iconChat\" src=\"https://cdn.discordapp.com/emojis/792849926769606737.gif?v=1\"></img>"],
    ["cac", "***"],
    ["cặc", "***"],
    ["lon", "***"],
    ["lồn", "***"],
    ["đm", "**"],
    ["dit", "***"],
    ["địt", "***"],
    ["djt", "***"],
    ["diss", "****"]
	];
	var finalText = text;

	for (var i = 0; i < emojRange.length; i++) {
		var range = emojRange[i];
		var re = new RegExp(range[0], "g");
		//finalText = finalText.replaceAll(range[0], range[1]);
		finalText = finalText.replace(re,range[1]);
		
	}
	
	//console.log(finalText);
	
	return finalText;
}