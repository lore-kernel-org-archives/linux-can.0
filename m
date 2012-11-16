From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Fri, 16 Nov 2012 16:13:15 +0100
Message-ID: <20121116151315.GB93742@airbook.eia.lan>
References: <2478881.znSzbTXnK5@uschi>
 <505777BC.3000705@hartkopp.net>
 <5058659E.2010804@grandegger.com>
 <50586A50.5060300@pengutronix.de>
 <loom.20121114T213201-791@post.gmane.org>
 <50A4E5FC.5020103@pengutronix.de>
 <50A52266.8030301@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:22645 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751966Ab2KPPNW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Nov 2012 10:13:22 -0500
Content-Disposition: inline
In-Reply-To: <50A52266.8030301@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Jason White <white_jason_r1@cat.com>, linux-can@vger.kernel.org

On Thu, Nov 15, 2012 at 06:12:06PM +0100, Oliver Hartkopp wrote:
> On 15.11.2012 13:54, Marc Kleine-Budde wrote:
> 
> > On 11/14/2012 09:48 PM, Jason White wrote:
> 
> 
> Officially the TX-timeout has been removed as the controller just sends out
> the CAN frames, when it comes back to life ...
> 
> The question is, if the controller gets into the BUS_OFF state and if the
> restart-ms option (see ip tool) would help here.
FYI:
A CAN chip that sits alone on a proper bus, trying to transmit a frame,
will never go into BUS_OFF. It can only go in BUS_OFF when a bad network
is encountered, i.e. the chip does not see it's TX activity on its RX.

I think this scenario (chip alone, going in BUS_OFF) is no different
than regular BUS_OFF, and should be treated likewise.
> 
> Regards,
> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
