From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: J1939
Date: Wed, 20 Nov 2013 10:36:12 +0100
Message-ID: <20131120093612.GD10573@vandijck-laurijssen.be>
References: <1384388788.4066.16.camel@hp-dhlii>
 <20131114203147.GA7128@vandijck-laurijssen.be>
 <1384532982.6591.14.camel@hp-dhlii>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:65410 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750858Ab3KTJgR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Nov 2013 04:36:17 -0500
Content-Disposition: inline
In-Reply-To: <1384532982.6591.14.camel@hp-dhlii>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Cc: linux-can@vger.kernel.org

Hi David,

On Fri, Nov 15, 2013 at 11:29:42AM -0500, David H. Lynch Jr. wrote:
> Hi Kurt;
> 
>     I mostly do board bringup work as a consultant. So I can handle merging a
> driver into the kernel or using one of the testing kernel trees.
> 
>     Many of my clients use CAN/J1939/NMEA2000/CANOpen, to this point I have
> always had to deal with these in userspace.
>     A standard stack that was in the kernel is very appealing.
> 
>     I have already pulled the 3 git repositories related to J1939.  But my
> quick skim did not  get me far.

Well, I suppose you got linux-can-j1939, can-j1939-utils & iproute2-j1939?
Please mind you want to select a proper branch of linux-can-j1939.

Did you manage to compile them?
The reason I ask this is that most questions I get wrt. j1939 is getting it
merged & compiled.
In the meanwhile, I updated the j1939 page on www.elinux.org with
basic instructions how to build.

> 
>     While I am primarily interested in sending/receiving J1939 messages at the
> socket level, even being able to use cansend to say send a J1939 engine speed
> would be really useful.
> 
>     i can already do that as the J1939 engine speed message fits in an ordinary
> CAN message - but all messages don't.

You're at the right address. The things you describe are exactly what
I implemented.

> 
>     Anyway if it is of value to you to have some one else using and testing
> this and providing feedback, to the extent that I can incorporate it into my
> existing work I would be happy to do so.

The GPL license allows you to reuse the components in your work.
Any real-world comments on the stack should be usefull.
In the past 2 years, some usefull improvements were made this way.

>    
>     When I get a bit more time to look through the code and Docs I will - the
> answers I am looking for are certainly there, I was just hoping to be able to
> get to testing some things quickly.  

I composed a simple kickstart guide to j1939 on linux for new collegues.
It may be of good use for you and others too.
I'm just looking for a place to share the thing.
Can elinux.org use markdown syntax?

Kurt

>      
> 
> 
> On Thu, 2013-11-14 at 21:31 +0100, Kurt Van Dijck wrote:
> 
>     Hi David,
> 
>     On Wed, Nov 13, 2013 at 07:26:28PM -0500, David H. Lynch Jr. wrote:
>     > I recently noticed that J1939 support has been incorporated into the
>     > Linux Kernel CAN stack.
> 
>     Well, the j1939 stack is not yet incorporated in mainline Linux.
>     It's API, which adheres to BSD socket semantics than raw CAN due
>     to the addressing concept, causes some resistance.
> 
>     You are of course welcome to share your opinions about that matter.
> 
>     Once the API is agreed, mainline should be easy.
> 
>     >
>     > I would be happy to help with testing that with some pointers.
> 
>     Great. I have performed only manual tests in the past to get
>     the stack right.
>     Some sort of automated test may be usefull to avoid
>     problems over time with refactoring or changing kernel
>     infrastructures.
> 
>     A sample of the code got certified in an ISOBUS product.
>     At that time, the code proved to be functional, both for
>     the normal use case as for a lot of erroneous situations.
> 
>     >
>     > Any simple examples of sending/receiving specific PGN's ?
> 
>     You can read Documentation/networking/j1939.txt.
>     The can-utils-j1939 package have some tools, but those do not expose
>     the easiest examples.
> 
>     I will add some easier examples that are a bit closer to real-life
>     programs.
> 
>     Kind regards,
>     Kurt
> 
> 

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
