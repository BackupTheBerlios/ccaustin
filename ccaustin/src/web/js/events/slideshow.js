
var whichimage = 0;
var slideShowSpeed = 9000;
var crossFadeDuration = 5;

var Pix = new Array();
Pix[0] = "../images/events/buildmobanner.jpg";
Pix[1] = "../images/events/CAM-banner.jpg";
Pix[2] = "../images/events/www-easterbanner.jpg";

var t;
var step = 0;
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
         document.images.SlideShow.src = preLoad[step].src;
  	 document.images.SlideShow.filters.blendTrans.play();
         whichimage=step
	}
  step = step + 1;
  if (step > (numPix - 1) ) 
        {
         step = 0;
        }
  t = setTimeout('runSlideShow()', slideShowSpeed);
}

runSlideShow()
function slideLink()
{
  if (whichimage==0)
	window.location="../buildingmomentum/index.html"
  else if (whichimage==1)
        window.location="http://www.calvaryaustinmusic.org"
  else if(whichimage==2)
        window.location="http://www.easterservice.com"
}

