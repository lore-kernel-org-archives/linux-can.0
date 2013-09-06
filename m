From: Markus Becker <mab@comnets.uni-bremen.de>
Subject: Re: Debian package configuration for can-utils
Date: Fri, 06 Sep 2013 20:37:28 +0200
Message-ID: <2835769.Zc3pei32RC@shelbyville.comnets.uni-bremen.de>
References: <5229E1D2.7090509@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bugs.comnets.uni-bremen.de ([134.102.186.10]:64705 "EHLO
	bugs.comnets.uni-bremen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889Ab3IFSq7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Sep 2013 14:46:59 -0400
In-Reply-To: <5229E1D2.7090509@i2se.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-can@vger.kernel.org

On Friday 06 September 2013 16:08:18 Stefan Wahren wrote:
> Hello Uwe,
> 
> i had read the discussion about Debian package for can-utils (
> http://thread.gmane.org/gmane.linux.can/3748 ) and i'm very interested
> about that.
> 
> Is there a public repository, where i can get can-utils including Debian
> package configuration?

I did some packaging back in April 2012 in Debian's collab-maint packaging 
effort:
http://anonscm.debian.org/gitweb/?p=collab-maint/can-utils.git;a=summary
http://anonscm.debian.org/gitweb/?p=collab-maint/can-modules.git;a=summary
(The last one mostly to get the ISO-TP modules.)

https://wiki.debian.org/Alioth/PackagingProject and
http://alioth.debian.org/projects/collab-maint/
describe on how to join packaging efforts.

To build from the git repo shoud be as easy as cloning and using dpkg-
buildpackage.

Markus

> Best regards
> Stefan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
------------------------------------------------
| Dipl.-Ing. Markus Becker
| Communication Networks
| TZI - Center for Computing Technologies
| University Bremen
| Germany
------------------------------------------------
| web: http://www-user.uni-bremen.de/~beckerm/
| mailto: mab@comnets.uni-bremen.de
| telephone: +49 421 218 62379
| building: NW1 room: N2260
------------------------------------------------
