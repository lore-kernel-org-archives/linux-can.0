From: Markus Becker <mab@comnets.uni-bremen.de>
Subject: Re: Re: RFS: socketcan-utils
Date: Wed, 11 Apr 2012 15:09:18 +0200
Message-ID: <201204111509.18993.mab@comnets.uni-bremen.de>
References: <201105021707.01903.mab@comnets.uni-bremen.de> <201105310946.46575.mab@comnets.uni-bremen.de> <4DE5492A.4050008@hartkopp.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bugs.comnets.uni-bremen.de ([134.102.186.10]:51194 "EHLO
	bugs.comnets.uni-bremen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760270Ab2DKNQt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 09:16:49 -0400
In-Reply-To: <4DE5492A.4050008@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

> On 31.05.2011 09:46, Markus Becker wrote:
> >> On 30.05.2011 09:16, Markus Becker wrote:
> >>> Well, we explicitly need isotp, which is not included in stock debian
> >>> images. That's actually the reason for creating the images. Any idea of
> >>> how to get Linux mainline isotp kernel module into the Debian kernel?
> >> 
> >> My problem is, that we're using my isotp stuff for many purposes for
> >> more than two years now. I'm not far from sending a patch on netdev-ML
> >> - but i'm still missing some feedback from isotp-users (like you), if
> >> they think the protocol and it's API are mature enough for mainline ...
> >> is it?
> > 
> > Within the next two month, we will test two telematic devices against
> > socketCAN ISO-TP and raw or J1939 frames. The Debian packages were
> > created to get our test equipment ready. Will report to you on our
> > experience.

Well it took longer... But here comes the report on our experience with ISO-
TP:

We tested successfully against two other proprietary ISO-TP CAN 
implementations with isotpsend and isotprecv without any problems.

> Thanks! You are also working with j1939 ?? Did you check out the work of
> Kurt van Dijck in socketcan/branches/j1939?

We did not use the j1939 branch up to now.

[...]

BR,
Markus

------------------------------------------------
| Dipl.-Ing. Markus Becker
| Communication Networks
| TZI - Center for Computing Technologies
| University Bremen
| Germany
------------------------------------------------
| web: http://www.comnets.uni-bremen.de/~mab/
| mailto: mab@comnets.uni-bremen.de
| telephone: +49 421 218 62379
| building: NW1 room: N2260
------------------------------------------------
