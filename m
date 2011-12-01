From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: git-tree, NOW!
Date: Thu, 01 Dec 2011 10:30:55 +0100
Message-ID: <4ED7494F.6080603@grandegger.com>
References: <48E9EDF6.4000009@pengutronix.de>
	<4ED6B460.2010508@pengutronix.de>	<4ED7351E.2010907@grandegger.com>
	<4ED745F6.8030302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED745F6.8030302-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On 12/01/2011 10:16 AM, Marc Kleine-Budde wrote:
> On 12/01/2011 09:04 AM, Wolfgang Grandegger wrote:
>>> I think we need a git tree. It's the second time our humble network
>>> maintainer merged some patches to early. IMHO both times related to bad
>>> communication.......
>>
>> What do you mean? Usually we do not communicate anything to Dave for the
>> normal v1->v2->v3->... review and patch update process (this does not
>> excuse the bad quality of my last series). The problem is that it's not
>> easy for him to follow our work and therefore we need our own GIT tree.
> 
> Yes - exactly. I think we're meaning the same:
> It's hard to figure out for him when a series is "ready", (or at least
> we think it is). We haven't communicated a "series is still in review"
> nor a "series is now ready".

Yes. So far we just tried to signal "patch is now ready" by adding our
"acked-by"... which does not work for a series of patches, espcially if
it touches other sub-systems as well (powerpc, devicetree).

> I like Oliver's remark to first keep the discussion on the linux-can
> mailinglist and post the "final" series on netdev.

Yes, don't ask me why I did not do that first, especially because some
tested-by's would have be useful. I also learned that some more serious
compile tests have to be done for different archs (x86, powerpc, arm, ...).

>> That's also what Dave asks for. Apart from the tree he asks for someone
>> who acts as the one and only interface to him.
> 
> Yes, technically that could/should be the git tree, in persona Wolfgang
> or/and (as Dave asked for one person) Oliver.

Oliver?

>>> I've setup a git repo on gitorious:
>>>
>>> https://gitorious.org/linux-can/linux-can
>>>
>>> It's based on net-next, and currently David's net-next/master is pushing
>>> there. It probably takes some time, the box pushing has just 4 mbit/s
>>> upstream.
>>>
>>> Comments?
>>
>> Apart from net-next, we may also need the net tree (as branch?).
> 
> During merge windows David merges into his net-next tree, anyway I can
> setup linux-can and linux-can-next, based on the linux-net and
> linux-net-next trees.

Do we need two trees? I thinks you can save a lot of bandwith (and disk
space) by using just one tree and two branches.

Wolfgang.
