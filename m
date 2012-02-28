From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Transport Protocol: example
Date: Tue, 28 Feb 2012 17:26:22 +0100
Message-ID: <20120228162622.GF495@e-circ.dyndns.org>
References: <20120116133140.GA26427@e-circ.dyndns.org>
 <loom.20120116T153805-349@post.gmane.org>
 <20120116153644.GA7763@e-circ.dyndns.org>
 <loom.20120207T160415-497@post.gmane.org>
 <20120208084602.GA412@e-circ.dyndns.org>
 <loom.20120216T104829-444@post.gmane.org>
 <20120216194911.GA447@e-circ.dyndns.org>
 <loom.20120224T154038-289@post.gmane.org>
 <20120228104605.GA495@e-circ.dyndns.org>
 <loom.20120228T151322-857@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:52562 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754958Ab2B1Q0Z (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 28 Feb 2012 11:26:25 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120228T151322-857@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Wagner <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Tue, Feb 28, 2012 at 03:21:17PM +0000, Wolfgang Wagner wrote:
> Hi Kurt,
> 
> Just whether I understood it right:
> 
> My "ECU" makes the negotiation with the sending node and write the TP.CM_RTS 
> and the TP.DT in the socket and after the complete reception it makes the 
> negotiation with the other node with sending the TP.CM_RTS and than sends the
> TP.DT?

Yes.

Kurt
> 
> --Wolfgang
> 
> 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
