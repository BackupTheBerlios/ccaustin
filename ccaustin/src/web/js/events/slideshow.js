
var Ref = new Array();
Ref[0] = "../events/buildingmomentum.html";
Ref[1] = "http://www.calvaryaustinmusic.org";

var Banner = new Array();
Banner[0] = "../images/events/buildmobanner";
Banner[1] = "../images/events/CAM-banner";



var slideShowSpeed = 8000;
var crossFadeDuration = 3;

var Pix = new Array();
Pix[0] = "../images/events/buildmobanner.jpg";
Pix[1] = "../images/events/CAM-banner.jpg";

var t;
var j = 0;
var numPix = Pix.length;

var preLoad = new Array();
for (i = 0; i < numPix; i++) 
{
  preLoad[i] = new Image();
  preLoad[i].src = Pix[i];
}

function runSlideShow() 
{
  if (document.images.SlideShow) 
	{
         document.images.SlideShow.style.filter="blendTrans(duration=5)";
         document.images.SlideShow.style.filter="blendTrans(duration=crossFadeDuration)";
         document.images.SlideShow.filters.blendTrans.apply();
        }

  if (document.images.SlideShow) 
	{
         document.images.SlideShow.src = preLoad[j].src;
  	 document.images.SlideShow.filters.blendTrans.play();
	}
  j = j + 1;
  if (j > (numPix - 1) ) 
        {
         j = 0;
        }
  t = setTimeout('runSlideShow()', slideShowSpeed);
}

function nextRef()
{
	document.links[0];
}

function nextBanner()
{
	eval(document.write('Banner(j)'));
}



