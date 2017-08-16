From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: bind() Host is down listening on j1939 interfaces
Date: Wed, 16 Aug 2017 23:28:27 +0200
Message-ID: <20170816212827.GG32670@airbook.vandijck-laurijssen.be>
References: <CAJn4=pX9FczzJSFfQPQ3ghSv+T6Lj1SirSmVH1f8mrOXRux-dQ@mail.gmail.com>
 <20170816094029.GD32670@airbook.vandijck-laurijssen.be>
 <CAJn4=pWXcvaXbZNxTmGj=8KV3RAWAwR7Hce7pb5jw7F=SGnrSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:36524 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbdHPVaP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 17:30:15 -0400
Content-Disposition: inline
In-Reply-To: <CAJn4=pWXcvaXbZNxTmGj=8KV3RAWAwR7Hce7pb5jw7F=SGnrSQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lehel Benedek <benedek.lehel@gmail.com>
Cc: linux-can@vger.kernel.org, cosmo@iocurrents.com

Hey,

> Hi Kurt,
> 
> I've been using the j1939-v2.6.35 branch from git,
That's old, but was supported.

> and doesn't seem to
> need enabling of the can-j1939 explicitly,
How did you conclude that?

> and "ip link set can0 type j1939" doesn't work,
Where did you find this command?

> but "modprobe can-j1939" does work!
> 
> When running the TestJ1939 the protocol seems to activate
> automatically (without needing to call modprobe):
> [   66.741478] can: controller area network core (rev 20090105 abi 8)
> [   66.754959] NET: Registered protocol family 29
> [   66.787201] can: SAE J1939
> 
> however gets stuck on the bind call with EHOSTDOWN.

[...]

> > I'll take a look this evening where the legacy documentation is exactly.

Please find relevant documentation for your version of can-j1939 support
at http://elinux.org/index.php?title=J1939&oldid=378716
I realize there is no real way you could have determined this yourself :-)
Anyway, if you follow this guid, it should bring you way further.

Kind regards,
Kurt

