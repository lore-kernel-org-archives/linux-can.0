From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: backporting can & can-j1939
Date: Tue, 13 Dec 2011 10:53:12 +0100
Message-ID: <20111213095312.GC430@e-circ.dyndns.org>
References: <20111209134721.GA309@e-circ.dyndns.org>
 <loom.20111209T145701-227@post.gmane.org>
 <20111209143224.GB309@e-circ.dyndns.org>
 <20111209144911.144460@gmx.net>
 <20111209150133.GA1470@e-circ.dyndns.org>
 <loom.20111209T175414-826@post.gmane.org>
 <20111212081217.GA351@e-circ.dyndns.org>
 <loom.20111212T121257-904@post.gmane.org>
 <20111212124031.GD351@e-circ.dyndns.org>
 <loom.20111212T160733-221@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:48507 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab1LMJxW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 13 Dec 2011 04:53:22 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111212T160733-221@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

Wolfgang,

I tried myself a little backport of net/can/ into 2.6.31.
It appears quite complex. It may be better to start over
with a fresh kernel, and copy those files from my
can-j1939-modules, since this repository contains
#if KERNEL_VERSION macros that will make it work on 2.6.31.

I'm even using this on 2.6.25, so don't worry, it _will_ work
sooner or later.

I'm not sure exactly how the include/socketcan from can-j1939-modules
should be merged into the kernel source.
I think this is a bit of a manual job to do for the header files.

Anyone better ideas?

Kind regards,
Kurt
