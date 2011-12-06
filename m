From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using j1939
Date: Tue, 6 Dec 2011 13:14:03 +0100
Message-ID: <20111206121403.GB322@e-circ.dyndns.org>
References: <20111206104432.91170@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:27302 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933368Ab1LFMOI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 Dec 2011 07:14:08 -0500
Content-Disposition: inline
In-Reply-To: <20111206104432.91170@gmx.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wutz@unterderbruecke.de
Cc: linux-can@vger.kernel.org

> I cloned the three repositories, can-j1939-modules, can-j1939, iproute2-1939 as you told me.
I suppose you meant 'can-j1939-modules', 'can-j1939-utils' and 'iproute2-j1939' ...

> Now I want to create new packages out of this repositories (I hope this is the right way). 
Packages?
I'm afraid you lost me on this. Using your (cross)toolchain, you do
$ make
etc. to compile (& install) the binaries.
> But now I am facing the next problem, what type of packages do I have to create for each particular repository?
I believe you're asking something for a specific build system, but I
do not know which one.
What build system do you use?

Would it be interesting to setup things on your (linux) host PC on a virtual CAN bus?
Then several things may be a lot easier.

Kurt
