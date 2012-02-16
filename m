From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: How to get the DA
Date: Thu, 16 Feb 2012 20:49:11 +0100
Message-ID: <20120216194911.GA447@e-circ.dyndns.org>
References: <4F0F2195.7050109@hartkopp.net>
 <20120113111251.GD319@e-circ.dyndns.org>
 <loom.20120113T122554-557@post.gmane.org>
 <loom.20120116T103812-141@post.gmane.org>
 <20120116133140.GA26427@e-circ.dyndns.org>
 <loom.20120116T153805-349@post.gmane.org>
 <20120116153644.GA7763@e-circ.dyndns.org>
 <loom.20120207T160415-497@post.gmane.org>
 <20120208084602.GA412@e-circ.dyndns.org>
 <loom.20120216T104829-444@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:49359 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525Ab2BPTtT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Feb 2012 14:49:19 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120216T104829-444@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Wagner <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Feb 16, 2012 at 09:58:27AM +0000, Wolfgang Wagner wrote:
> Hi Kurt,
> 
> is there a simple way to get the destination address out of the ID, or has it to
> be done with the struct cmsghdr, like implement in the jspy?
There is no simpler way.

Retreiving the original Destination address is in most cases irrelevant.
Receiving the message means that you should process it (in most cases).
I admit that your usecase, being a bridge, is a major exception to this
rule.
Like the message priority, the original destination address did not make
it into the a simple API.

Looking at your attempt, I'm a bit glad I did not totally strip these
attributes, and kept the available, altough  they're a bit hard to fetch :-)

Kurt
