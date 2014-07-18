From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: CAN Utils
Date: Fri, 18 Jul 2014 20:08:19 +0200
Message-ID: <20140718180819.GA24305@vandijck-laurijssen.be>
References: <ahafkglomfqdhtkargpl@sawx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:22301 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422813AbaGRSIZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Jul 2014 14:08:25 -0400
Content-Disposition: inline
In-Reply-To: <ahafkglomfqdhtkargpl@sawx>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jan Kinkazu <kinkazu@interia.eu>
Cc: linux-can@vger.kernel.org

On Fri, Jul 18, 2014 at 10:14:21AM +0200, Jan Kinkazu wrote:
> Hi Kurt.
> 
> Sorry for botherring you on your private email, but I don't know which forum to
> join to have a contact with you.
> 
> I would like to ask you 2 questions regardig your J1939 stack and can utils.
> 
> I have very very limited knowledge how CAN or J1939 works, but I was able to
> include your patch to kernel, install iproute with your commits, install your
> can-j1939-utils.
> 
> The first question is:
> 
> Do I need your J1939 stack if the only think I want to do is receive data from
> the J1939 engine?

If you want to seamlessly use transport protocol,
you could use my J1939 stack.
dynamic addressing (address claiming) is probably not usefull since engine controllers
sit on 0x00.

> 
> I have both can-utils and can-J1939-utils and candump shows exactly the same
> info.

can-j1939-utils is can-utils + some j1939 specific tools.
candump is supposed to work exactly the same.

> 
> The second question is:
> 
> Why cansniffer shows nothing wile candump shows properly can0 traffic?

I'm not familiar with cansiffer.

> 
> Kind Regards
> 
> 
> P.S
> 
> If you tell me where, i will post my questions on the forum so everybody can
> drink from the well of your wisdom

the proper place is linux-can@vger.kernel.org
which I added in CC

> 
