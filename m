From: Konrad Anton <konrad.anton@awinia.de>
Subject: Re: [PATCH] cangen: use long long in time computation for -g to support
 >2.1s
Date: Thu, 07 Feb 2013 12:04:36 +0100
Message-ID: <51138A44.5090306@awinia.de>
References: <20130207101708.B072CFC0@ratt.gitorious.c.bitbit.net> <1360233489-14471-1-git-send-email-mkl@pengutronix.de> <511384F4.703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from static.19.126.47.78.clients.your-server.de ([78.47.126.19]:44184
	"EHLO sys1.syste.me" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751962Ab3BGLLT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 7 Feb 2013 06:11:19 -0500
In-Reply-To: <511384F4.703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

On 07.02.2013 11:41, Marc Kleine-Budde wrote:
> we're a bit oldschool and discuss the code on the
> linux-can@vger.kernel.org mailinglist. Feel free to subscribe.

Can you please put that information on the Gitorious page for the next=20
casual committer?


>>   	ts.tv_sec =3D gap / 1000;
>> -	ts.tv_nsec =3D ((int)(gap * 1000000)) % 1000000000;
>> +	ts.tv_nsec =3D (long)(((long long)(gap * 1000000)) % 1000000000ll)=
;
>
> What's going on here exactly?
>
> gap is a double - Will it be converted into an int before multiplicat=
ion
> with 1000000? IIRC there is a difference between "gap * 1000000" and
> "gap * 1000000.0". In the latter the multiplication is done in floati=
ng
> point, because of the ".0".

gap is a double.
(gap * 1000000) will cause 1000000 to be converted to intermediate=20
temp1 of type double,
temp1 will be truncated to long long temp2, losing its decimals,
temp2 will be moduloed by 1000000000ll in a long-long mod operation,=20
giving temp3.
temp3 will be truncated to as many bits as long has, and stored in long=
=20
tv_nsec.

I think it is safe.

--Konrad



--=20
-----------------------------------------------------------------------=
-
Konrad Anton
awinia gmbh, Software Consulting and Development
Max-Josef-Metzger-Str. 2, D-79111 Freiburg
Tel. +49 761 52 07 449 19
=46ax. +49 761 52 07 449 10
EMail: konrad.anton@awinia.de
Handelsregister Nr.: HRB 706296, eingetragen beim Amtsgericht Freiburg
USt.-IdNr.: DE 275018159
Gesch=E4ftsf=FChrer: Marc Gossweiler, Bernd Wiedle
-----------------------------------------------------------------------=
-
