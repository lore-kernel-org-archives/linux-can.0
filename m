From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] CAN FD support
Date: Thu, 3 May 2012 15:00:41 +0200
Message-ID: <20120503130041.GA2846@vandijck-laurijssen.be>
References: <4FA2689D.5030905@hartkopp.net>
 <4FA26D28.80307@grandegger.com>
 <4FA26F65.5020804@hartkopp.net>
 <4FA275C1.4080905@grandegger.com>
 <20120503121833.GC416@vandijck-laurijssen.be>
 <4FA27C3C.8010806@hartkopp.net>
 <4FA27D88.8040401@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:47136 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356Ab2ECNAo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 May 2012 09:00:44 -0400
Content-Disposition: inline
In-Reply-To: <4FA27D88.8040401@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> 
> Furthermore, the user should be allowed to specify *any* lenght below
> max, als 57 bytes. It's than up to the driver to do the necessary padding.
I think Oliver solved this (on af_can level?) with a table len2dlc (static in the header?)

> 
> > 
> > What about this binary compatible introduction of cf->len ...
> 
> Looks good.
Yep, given 2 structs, this illustrates the contents very well!

Kurt
