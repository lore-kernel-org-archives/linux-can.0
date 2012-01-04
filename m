From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using can-j1939
Date: Wed, 4 Jan 2012 10:47:15 +0100
Message-ID: <20120104094715.GB320@e-circ.dyndns.org>
References: <20111220150545.GC311@e-circ.dyndns.org>
 <loom.20111220T160841-487@post.gmane.org>
 <20111220163247.GE311@e-circ.dyndns.org>
 <loom.20111221T111539-419@post.gmane.org>
 <20111221134302.GA12050@e-circ.dyndns.org>
 <loom.20111221T153828-216@post.gmane.org>
 <20111221155314.GC12050@e-circ.dyndns.org>
 <loom.20111222T115004-22@post.gmane.org>
 <20111223110445.GB12091@e-circ.dyndns.org>
 <loom.20111228T114009-686@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:26295 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696Ab2ADJrS (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 4 Jan 2012 04:47:18 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111228T114009-686@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Wed, Dec 28, 2011 at 10:49:39AM +0000, Wolfgang wrote:
> Hi,
> 
> am I right, if I start for every pgn I want to bridge a new process? Or will it
> work if all pgns to be bridged are in one process? I'm just wondering what will
> bring a better performance? 
A third option is to start 1 process, with different sockets, each socket bridging 1 pgn.

They all work.
I have no idea what will bring the best performance.
I think your second option will bring:
* the most understandable source code...
* less memory consumption
* less scheduler load
* more transparency (FIFO operation is lost when using different processes)

Kurt
> 
> --Wolfgang
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
