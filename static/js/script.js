 const RANDOM_IMAGE_URL = "http://localhost:8080/simba/external/api/v1/pad-dashboard/image";
//const RANDOM_IMAGE_URL = "https://app-test-simba.azurewebsites.net/simba/external/api/v1/pad-dashboard/image";

document.addEventListener("load", onInit());

function onInit(){
    loadRandomImage();
}

const badgeCard = document.querySelector('.badge-card');
const arrow = document.querySelector('.arrow-right');
const noBadgeToggledContent = document.querySelector('.no-badge-content');
const noAccountToggledContent = document.querySelector('.no-account-content');
const noBadgeToggledButton = document.querySelector('.toggle-button-top');
const noAccountToggledButton = document.querySelector('.toggle-button-bottom');

var noBadgeToggled = false;
var noAccountToggled = false;

badgeCard.addEventListener('click', launchAnimation);
fetchData();

async function fetchData() {
  try {
      const response = await fetch('/waiting');
      const data = await response.json();
      if (data.redirect_url) {
        await launchAnimation();
        window.location.href = data.redirect_url;
      } else {
          console.error('Error: No redirect URL in response');
      }
  } catch (error) {
      console.error('Error calling the API:', error);
  }
}
async function loadRandomImage() {
    try {
        // Call the `/image` endpoint to get the image URL
        const response = await fetch(RANDOM_IMAGE_URL);
        
        if (!response.ok) {
            throw new Error(`Failed to fetch image: ${response.statusText}`);
        }

        // Parse the image URL from the response
        document.getElementById("randomImage").src = await response.text();
    } catch (error) {
        console.error('Error loading random image:', error);
    }
}
function launchAnimation() {
    return new Promise((resolve) => {
        console.log("test 3");
        badgeCard.style.animation = 'none';
        void badgeCard.offsetWidth;
        badgeCard.style.animation = 'badged 1.5s forwards';

        arrow.style.display = 'none';

        badgeCard.addEventListener('animationend', function() {
            badgeCard.style.position = 'fixed';
            badgeCard.style.right = 'calc(50% - 165px)';
            badgeCard.style.bottom = 'calc(50% - 100px)';
            badgeCard.style.transform = 'scale(40) rotate(0deg)';
            resolve();
        }, { once: true });
    });
}

const BORDER = '2px solid rgb(102, 102, 102)';

function toggleAccordion(number){
    if(number === 1){
        if(noBadgeToggled){
            noBadgeToggledContent.style.display = 'none';
            noBadgeToggledButton.style.borderBottom = BORDER;
            noBadgeToggled = false;
        } else {
            noBadgeToggledContent.style.display = 'block';
            noBadgeToggledButton.style.borderBottom = 'none';
            noAccountToggledButton.style.borderBottom = BORDER;
            noBadgeToggled = true;
        }

        noAccountToggledContent.style.display = 'none';
        noAccountToggled = false;
    } else if (number === 2){
        if(noAccountToggled){
            noAccountToggledContent.style.display = 'none';
            noAccountToggledButton.style.borderBottom = BORDER;
            noAccountToggled = false;
        } else {
            noAccountToggledContent.style.display = 'block';
            noAccountToggledButton.style.borderBottom = 'none';
            noBadgeToggledButton.style.borderBottom = BORDER;
            noAccountToggled = true;
        }

        noBadgeToggledContent.style.display = 'none';
        noBadgeToggled = false;
    }
}