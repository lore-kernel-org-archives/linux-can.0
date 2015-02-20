From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Standard CAN over IP
Date: Fri, 20 Feb 2015 12:43:22 +0100
Message-ID: <54E71DDA.9000807@hartkopp.net>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com> <CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:10943 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbbBTLnc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Feb 2015 06:43:32 -0500
In-Reply-To: <CAKSnaaeezGJzR_ZHq4e1Ow1fnQzOwbEw7feM7v_2f3snNddA0g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TWF4aW1pbGlhbiBHw7xudG5lcg==?= <maximilian.guentner@gmail.com>, Mike Purvis <mpurvis@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org, tom_usenet@optusnet.com.au

On 18.02.2015 18:57, Maximilian G=C3=BCntner wrote:

> Some features are still missing, like packet loss detection and the
> re-transmission of lost UDP packets. CAN_FD is also not implemented.

Hi Maximilian,

I would suggest to implement CAN FD from the beginning.

When creating the CAN RAW socket just try to switch it into CAN FD mode=
:

const int canfd_on =3D 1;

/* try to switch the socket into CAN FD mode */
setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(canfd_o=
n));

No need to check for the return value here if you are able to handle CA=
N FD in=20
your application.

And do this CAN FD sockopt on the target socket too.
When you are getting CAN FD frames and the target CAN interface only su=
pports=20
CAN2.0 the FD frames have to be dropped - people will surely detect thi=
s :-)

The only problem will remain how to encapsulate two different frame len=
gths=20
and parse them correctly at the target node.

I wasn't able to get behind your UDP CAN frame encapsulation concept (m=
issing=20
C++ knowledge) so you definitely know better than me :-)

Regards,
Oliver
