From: =?ISO-8859-15?Q?Fran=E7ois?= <fbeaulier@orange.fr>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Wed, 24 Apr 2013 23:02:09 +0200
Message-ID: <51784851.1000208@orange.fr>
References: <5169B395.2070703@hartkopp.net> <516D2ABB.4000300@pengutronix.de> <5177A090.6010904@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:22511 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab3DXVKG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 17:10:06 -0400
In-Reply-To: <5177A090.6010904@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Stephane,

This is what i have done in a open source project i have started, a web=
=20
can analyzer called ewecan (https://bitbucket.org/Mongo/ewecan):
It parses /sys/class/net but unfortunately, as noted in comments, it=20
cannot make the difference between up or down interfaces.

/* Get a list of available socketcan interfaces and return them in
    a string as a JS array like ["can0", "can1", "vcan"]
    Returned string must be freed after use
    BUG : it also returns interfaces that are present but down !
*/
char *cmd_listitf(void)
{
     char *buf =3D malloc(255);
     if(!buf)
         return NULL;
     /* looking for socketcan interfaces in /sys */
     DIR *fdir =3D opendir("/sys/class/net");
     if(fdir =3D=3D NULL){
         perror("opendir");
         free(buf);
         return NULL;
     }
     struct dirent *fic;
     int firstdone =3D 0;
     buf[0] =3D '[';
     buf[1] =3D '\0';
     while(1){
         fic =3D readdir(fdir);
         if(fic =3D=3D NULL)
             break;
         if(!strstr(fic->d_name, "can"))
             continue;
         /* if the new string does not fit in buf, stop here */
         if((strlen(fic->d_name) + strlen(buf) + 4) >=3D 255)
             break;
         if(firstdone)
             strcat(buf, ",");
         strcat(buf, "\"");
         strcat(buf, fic->d_name);
         strcat(buf, "\"");
         firstdone =3D 1;
     }
     strcat(buf, "]");
     closedir(fdir);
     return buf;
}

Hope it can help !

Regards

--
=46ran=E7ois Beaulier
www.ingelibre.fr

Le 24/04/2013 11:06, Stephane Grosjean a =E9crit :
> Hi linux-can members,
>
> I currently wonder whether it exists any way of getting the list of=20
> the installed CAN interfaces, from a C program?
> I mean, getting the network interfaces list is available using=20
> ioctl(SIOCGIFCONF).
> But AFAIK, this (only) returns the IP interfaces found in the system,=
=20
> even using a socket CAN file descriptor.
> And, I would also like to avoid some pipe/fork/grep/sed in this C=20
> program too ;-)
>
> Thanks for your help and best regards,
>
> St=E9phane
> --=20
> PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
> Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=
=20
> HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
> Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
> ----
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

