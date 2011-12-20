From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: API calls
Date: Tue, 20 Dec 2011 16:05:45 +0100
Message-ID: <20111220150545.GC311@e-circ.dyndns.org>
References: <20111215140012.GA10848@e-circ.dyndns.org>
 <loom.20111215T152334-981@post.gmane.org>
 <20111216083708.GA323@e-circ.dyndns.org>
 <loom.20111216T095547-967@post.gmane.org>
 <20111216093308.GB669@e-circ.dyndns.org>
 <loom.20111216T150333-707@post.gmane.org>
 <20111217192038.GA309@e-circ.dyndns.org>
 <loom.20111220T112550-205@post.gmane.org>
 <20111220110059.GA311@e-circ.dyndns.org>
 <loom.20111220T150849-247@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:40143 "EHLO eia-vsv02.eia.lan"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751334Ab1LTPFt (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Dec 2011 10:05:49 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111220T150849-247@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Tue, Dec 20, 2011 at 02:49:43PM +0000, Wolfgang wrote:
> 
> I changed the program, but I am wondering how to send an entire j1939 frame with
> the data?

send(s, data, sizeof(data), 0) does send. But I see 'data' not defined?

I'm afraid I don't really understand the question this time ...
Can you explain a bit more?

Kurt
