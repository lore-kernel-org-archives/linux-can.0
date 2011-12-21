From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: using can-j1939
Date: Wed, 21 Dec 2011 14:43:02 +0100
Message-ID: <20111221134302.GA12050@e-circ.dyndns.org>
References: <20111216093308.GB669@e-circ.dyndns.org>
 <loom.20111216T150333-707@post.gmane.org>
 <20111217192038.GA309@e-circ.dyndns.org>
 <loom.20111220T112550-205@post.gmane.org>
 <20111220110059.GA311@e-circ.dyndns.org>
 <loom.20111220T150849-247@post.gmane.org>
 <20111220150545.GC311@e-circ.dyndns.org>
 <loom.20111220T160841-487@post.gmane.org>
 <20111220163247.GE311@e-circ.dyndns.org>
 <loom.20111221T111539-419@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:20109 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1LUNnJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Dec 2011 08:43:09 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111221T111539-419@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Wed, Dec 21, 2011 at 10:46:44AM +0000, Wolfgang wrote:
> 
> It is working, the ID is composed 18FFD080, thanks. I also tried recv() - it is 
> working as well. 
Great!!

> Is it possible to implement only the bytes you really need from the data array,
> because the dlc is always 8.
I bet len (= sizeof(frame.data) in your example) is 8.
If you want to send 3 bytes, then supply 3 bytes to the kernel!
> So sendto() is used to send to a specific address, at the moment I am always
> doing broadcast?
yes.
> 
> --Wolfgang
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
