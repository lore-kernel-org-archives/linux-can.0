From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using can-j1939
Date: Thu, 15 Dec 2011 16:06:27 +0100
Message-ID: <20111215150627.GB10848@e-circ.dyndns.org>
References: <20111214154351.GB6112@e-circ.dyndns.org>
 <loom.20111214T190347-790@post.gmane.org>
 <20111214204237.GC306@e-circ.dyndns.org>
 <loom.20111215T085023-710@post.gmane.org>
 <20111215092018.GB321@e-circ.dyndns.org>
 <loom.20111215T114301-18@post.gmane.org>
 <20111215120434.GD321@e-circ.dyndns.org>
 <loom.20111215T142642-767@post.gmane.org>
 <20111215140012.GA10848@e-circ.dyndns.org>
 <loom.20111215T152334-981@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:29713 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab1LOPGc (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 10:06:32 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111215T152334-981@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 15, 2011 at 02:49:44PM +0000, Wolfgang wrote:
> > Before proceeding however, what exactly is the application?
> > Will you bridge j1939 packets unmodified?
> 
> I want read from one bus modify the data field of the j1939 frame and write the
> modified packet on the other bus.
So only 1 PGN is bridged? No other PGN's.

Kurt
