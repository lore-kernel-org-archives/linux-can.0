From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v5 0/5] Consolidate and unify state change handling
Date: Thu, 18 Dec 2014 12:15:02 +0000
Message-ID: <20141218121502.24633.14829@shannon>
References: <a0f69b4e-b1d5-4c3e-b960-b9f2b34a4e1a@GRBSR0089.marel.net>
 <loom.20141218T070747-796@post.gmane.org> <549280D0.6060507@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0055.outbound.protection.outlook.com ([157.56.112.55]:63923
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751910AbaLRMPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Dec 2014 07:15:12 -0500
In-Reply-To: <549280D0.6060507@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

Quoting Oliver Hartkopp (2014-12-18 07:22:56)
> On 18.12.2014 07:09, Tom Evans wrote:
> > Andri Yngvason <andri.yngvason <at> marel.com> writes:
> >> Tested on sja1000 using
> >>   cangen -Ii -g 100 can0
> >> and
> >>   candump -ta -e can0,0:0,#FFFFFFFF
> >>
> >> Disconnected bus:
> >>   (1417614605.207964)  can0  07D   [6]  49 6E A1 7A 2A 3D
> >>   (1417614605.308206)  can0  07E   [8]  5F 18 AA 0F E5 82 CA 11
> >>   (1417614605.408107)  can0  07F   [5]  3E 12 B0 68 1A
> >>   (1417614605.514235)  can0  20000004   [8]  00 08 00 00 00 00 60 00
> > ERRORFRAME
> >>      controller-problem{tx-error-warning}
> >>      error-counter-tx-rx{{96}{0}}
> >
> > Is the version of candump that supports "-e" and prints the errors
> > available? It would be very useful in my current testing.
> >
> 
> The candump in can-utils provide this option:
> 
>         https://gitorious.org/linux-can/can-utils/
> 
> You may "git clone" the latest version and build it from source.
> 
> If you have a recent Debian or Ubuntu-style distro on your Linux-box:
> 
>         apt-get install can-utils
> 
> will make it.
> 

Actually, you'll need to apply this patch:
	http://article.gmane.org/gmane.linux.can/7165/

I think it hasn't been applied yet.

--
Andri
