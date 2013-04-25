From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 10:04:27 +0200
Message-ID: <20130425080427.GB448@vandijck-laurijssen.be>
References: <5169B395.2070703@hartkopp.net>
 <516D2ABB.4000300@pengutronix.de>
 <5177A090.6010904@peak-system.com>
 <51784851.1000208@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:51529 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755416Ab3DYIEd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 25 Apr 2013 04:04:33 -0400
Content-Disposition: inline
In-Reply-To: <51784851.1000208@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?B?RnJhbsOnb2lz?= <fbeaulier@orange.fr>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

man if_nameindex

if_nameindex does a similar thing :-)

And does not return the type of interface neither.

Kurt

On Wed, Apr 24, 2013 at 11:02:09PM +0200, Fran=C3=A7ois wrote:
> Stephane,
>=20
> This is what i have done in a open source project i have started, a
> web can analyzer called ewecan (https://bitbucket.org/Mongo/ewecan):
> It parses /sys/class/net but unfortunately, as noted in comments, it
> cannot make the difference between up or down interfaces.
>=20
> /* Get a list of available socketcan interfaces and return them in
>    a string as a JS array like ["can0", "can1", "vcan"]
>    Returned string must be freed after use
>    BUG : it also returns interfaces that are present but down !
> */
> char *cmd_listitf(void)
> {
>     char *buf =3D malloc(255);
>     if(!buf)
>         return NULL;
>     /* looking for socketcan interfaces in /sys */
>     DIR *fdir =3D opendir("/sys/class/net");
>     if(fdir =3D=3D NULL){
>         perror("opendir");
>         free(buf);
>         return NULL;
>     }
>     struct dirent *fic;
>     int firstdone =3D 0;
>     buf[0] =3D '[';
>     buf[1] =3D '\0';
>     while(1){
>         fic =3D readdir(fdir);
>         if(fic =3D=3D NULL)
>             break;
>         if(!strstr(fic->d_name, "can"))
>             continue;
>         /* if the new string does not fit in buf, stop here */
>         if((strlen(fic->d_name) + strlen(buf) + 4) >=3D 255)
>             break;
>         if(firstdone)
>             strcat(buf, ",");
>         strcat(buf, "\"");
>         strcat(buf, fic->d_name);
>         strcat(buf, "\"");
>         firstdone =3D 1;
>     }
>     strcat(buf, "]");
>     closedir(fdir);
>     return buf;
> }
>=20
> Hope it can help !
>=20
> Regards
>=20
> --
> Fran=C3=A7ois Beaulier
> www.ingelibre.fr
>=20
> Le 24/04/2013 11:06, Stephane Grosjean a =C3=A9crit :
> >Hi linux-can members,
> >
> >I currently wonder whether it exists any way of getting the list
> >of the installed CAN interfaces, from a C program?
> >I mean, getting the network interfaces list is available using
> >ioctl(SIOCGIFCONF).
> >But AFAIK, this (only) returns the IP interfaces found in the
> >system, even using a socket CAN file descriptor.
> >And, I would also like to avoid some pipe/fork/grep/sed in this C
> >program too ;-)
> >
> >Thanks for your help and best regards,
> >
> >St=C3=A9phane
> >--=20
> >PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
> >Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA
> >Darmstadt HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078,
> >WEE-Reg.-Nr.: DE39305391 Tel.+49 (0)6151-817320 / Fax:+49
> >(0)6151-817329, info@peak-system.com
> >----
> >To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
