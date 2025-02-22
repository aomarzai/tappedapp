import { SocialFollowing, UserModel } from "../types/models";

export const contactVenueTemplate = ({ performer, emailText }: {
  performer: UserModel,
  emailText: string,
}): { html: string; text: string } => {
  const username = performer.username;
  const displayName = performer.artistName || username;

  const html = `
  <p>Hey</p>

  <p>${emailText}</p> 
  
    ${formatSocialLinks(performer.socialFollowing)}

    <p>You can check my past booking history on my here <a href="https://tapped.ai/${username}">https://tapped.ai/${username}</a></p>

    ${formatPressKit(performer)}
  
  <p>If you require any additional information or wish to discuss this opportunity further please email me back and let me know.<p>
  
  <p>Thanks,</p>
  <p>${displayName}</p>

  <p>Sent from <a href="https://tapped.ai">Tapped Ai</a></p>
  `;

  const text = `
    Hey, 

    ${emailText}

    ${formatSocialLinksText(performer.socialFollowing)}

    Past Bookings:  You can check my past booking history on my here https://tapped.ai/${username}

    ${formatPressKitText(performer)}

    If you require any additional information or wish to discuss this opportunity further please email me back and let me know.

    Sent from Tapped Ai

    Thanks,
    ${displayName}
  `

  return {
    text,
    html,
  };
}

const formatSocialLinks = (
  socialFollowing: SocialFollowing,
): string => {
  const { 
    instagramHandle, 
    facebookHandle, 
    twitterHandle, 
    spotifyUrl, 
    youtubeChannelId,
    soundcloudHandle,
  } = socialFollowing;
  const row = (label: string, link: string) => {
    if (!link) {
      return "";
    }
    return `<p>${label}: <a href="${link}">${link}</a></p>`;
  }

  const instagram = instagramHandle ? row("Instagram", `https://instagram.com/${instagramHandle}`) : "";
  const facebook = facebookHandle ? row("Facebook", `https://facebook.com/${facebookHandle}`) : "";
  const twitter = twitterHandle ? row("Twitter", `https://twitter.com/${twitterHandle}`) : "";
  const spotify = spotifyUrl ? row("Spotify", spotifyUrl) : "";
  const youtube = youtubeChannelId ? row("Youtube", `https://youtube.com/channel/${youtubeChannelId}`) : "";
  const soundcloud = soundcloudHandle ? row("Soundcloud", `https://soundcloud.com/${soundcloudHandle}`) : "";

  const socialLinks = `
    <div style="margin-top: 20px;">
      <h3>Social Links</h3>
      ${instagram}
      ${facebook}
      ${twitter}
      ${spotify}
      ${youtube}
      ${soundcloud}
    </div>
    `;

  return socialLinks;
}

const formatSocialLinksText = (
  socialFollowing: SocialFollowing,
): string => {
  const { 
    instagramHandle, 
    facebookHandle, 
    twitterHandle, 
    spotifyUrl, 
    youtubeChannelId,
    soundcloudHandle,
  } = socialFollowing;
  const row = (label: string, link: string) => {
    if (!link) {
      return "";
    }
    return `${label}: ${link}`;
  }

  const instagram = instagramHandle ? row("Instagram", `https://instagram.com/${instagramHandle}`) : "";
  const facebook = facebookHandle ? row("Facebook", `https://facebook.com/${facebookHandle}`) : "";
  const twitter = twitterHandle ? row("Twitter", `https://twitter.com/${twitterHandle}`) : "";
  const spotify = spotifyUrl ? row("Spotify", spotifyUrl) : "";
  const youtube = youtubeChannelId ? row("Youtube", `https://youtube.com/channel/${youtubeChannelId}`) : "";
  const soundcloud = soundcloudHandle ? row("Soundcloud", `https://soundcloud.com/${soundcloudHandle}`) : "";

  const socialLinks = `
        Social Links
        ${instagram}
        ${facebook}
        ${twitter}
        ${spotify}
        ${youtube}
        ${soundcloud}
        `;

  return socialLinks;
}

const formatPressKit = (performer: UserModel): string => {
  const pressKitUrl = performer.performerInfo?.pressKitUrl;
  if (!pressKitUrl) {
    return "";
  }
  return `
    <p>my press kit: <a href="${pressKitUrl}">${pressKitUrl}</a></p>
  `;
}

const formatPressKitText = (performer: UserModel): string => {
  const pressKitUrl = performer.performerInfo?.pressKitUrl;
  if (!pressKitUrl) {
    return "";
  }
  return `my press kit: ${pressKitUrl}`;
}