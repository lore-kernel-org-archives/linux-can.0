From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can-utils 1/3] Update license information for some header
 files
Date: Sun, 12 Jan 2014 11:09:21 +0100
Message-ID: <52D269D1.9030009@hartkopp.net>
References: <20130817190521.GK30496@pengutronix.de> <1389481823-8379-1-git-send-email-u.kleine-koenig@pengutronix.de> <1389481823-8379-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:57134 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaALKJZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jan 2014 05:09:25 -0500
In-Reply-To: <1389481823-8379-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>



On 12.01.2014 00:10, Uwe Kleine-K=F6nig wrote:
> This corresponds to Linux commits
>   2485602f1af2 (can: add explicit copyrights to can headers)
>   1c2da13c21a1 (can: add explicit copyrights to can's netlink header)
> ---
> Hello,
>=20
> I would have expected to just need to do something like:
>=20
> cd $path_to_canutils
> rm -r include/socketcan/can
> cd $path_to_linux
> git archive --format=3Dtar --prefix=3Dsocketcan/can/ v3.13-rc7:includ=
e/uapi/linux/can | tar xC $path_to_canutils/include
> git cat-file blob v3.13-rc7:include/uapi/linux/can.h > $path_to_canut=
ils/include/socketcan/can.h
>=20
> to sync the header files. I didn't test but some changes introduced b=
y
> the above sequence seem to be uncompilable so I choosed to only
> cherry-pick the two Linux commits. IMHO this is a bug (in Linux or
> can-utils or maybe both).
>=20
> Best regards
> Uwe
>=20
>  include/socketcan/can/bcm.h     | 32 +++++++++++++++++++++++++++++++=
+
>  include/socketcan/can/error.h   | 32 +++++++++++++++++++++++++++++++=
+
>  include/socketcan/can/gw.h      | 32 +++++++++++++++++++++++++++++++=
+
>  include/socketcan/can/netlink.h |  8 ++++++++
>  include/socketcan/can/raw.h     | 32 +++++++++++++++++++++++++++++++=
+
>  5 files changed, 136 insertions(+)

Hello Uwe,

thanks for the effort.

Btw.

- include/socketcan/can.h
- include/socketcan/can/isotp.h

are both missing in this process.

Unfortunately we missed linux/include/uapi/linux/can.h in commit 248560=
2f1af2
(can: add explicit copyrights to can headers).

Would you like to pick this update of your original commit too?

Best regards,
Oliver


