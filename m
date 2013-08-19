From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils] Don't overwrite PREFIX and DESTDIR when provided
 via the environment
Date: Mon, 19 Aug 2013 19:23:09 +0200
Message-ID: <5212547D.9060402@hartkopp.net>
References: <1376767690-8472-1-git-send-email-u.kleine-koenig@pengutronix.de> <520FCFDD.7010308@pengutronix.de> <5210A9C5.5070309@hartkopp.net> <20130818204930.GM30496@pengutronix.de> <52113E45.4090300@pengutronix.de> <20130819083754.GN30496@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:35707 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3HSRXK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Aug 2013 13:23:10 -0400
In-Reply-To: <20130819083754.GN30496@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 19.08.2013 10:37, Uwe Kleine-K=F6nig wrote:
> On Sun, Aug 18, 2013 at 11:36:05PM +0200, Marc Kleine-Budde wrote:
>> On 08/18/2013 10:49 PM, Uwe Kleine-K=F6nig wrote:
>> [...]
>>
>>>> 1. good idea - I already pushed it to the git tree
>>> Thanks, but you somehow messed up the attribution. All three patche=
s I
>>> sent in the last few days appear with author=3Dyou :-(
>>
>> We can force-push-fix that :)
> If you want, a command to fix these three commits is:
>=20
> 	git filter-branch --env-filter 'case $GIT_COMMIT in b945b274ae48b48d=
2d4c21e115da69db1d9ec28a) GIT_AUTHOR_NAME=3D"Uwe Kleine-K=F6nig"; GIT_A=
UTHOR_EMAIL=3D"u.kleine-koenig@pengutronix.de"; GIT_AUTHOR_DATE=3D"Thu,=
 15 Aug 2013 20:59:26 +0200";; 8d5d80d0eae82e345e257a262a1e5b975ba4cbc0=
) GIT_AUTHOR_NAME=3D"Uwe Kleine-K=F6nig"; GIT_AUTHOR_EMAIL=3D"u.kleine-=
koenig@pengutronix.de"; GIT_AUTHOR_DATE=3D"Thu, 15 Aug 2013 22:58:19 +0=
200";; 903357e71a8994d8a821df6b31b86240f851dec1) GIT_AUTHOR_NAME=3D"Uwe=
 Kleine-K=F6nig"; GIT_AUTHOR_EMAIL=3D"u.kleine-koenig@pengutronix.de"; =
GIT_AUTHOR_DATE=3D"Sat, 17 Aug 2013 21:28:10 +0200";; esac' HEAD~4..
>=20
> That fixes just the author and date of the three commits in master
> without changing anything else.
>=20

Done.

I did not intentionally replace you as author.

When i do a similar commit from a mail, I=92ll take care about not loos=
ing the
original author anymore.

Git still is mystic to me 8-)

Best regards,
Oliver


