From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: git-tree, NOW!
Date: Thu, 01 Dec 2011 09:04:46 +0100
Message-ID: <4ED7351E.2010907@grandegger.com>
References: <48E9EDF6.4000009@pengutronix.de> <4ED6B460.2010508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4ED6B460.2010508-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Hi Marc,

On 11/30/2011 11:55 PM, Marc Kleine-Budde wrote:
> Hello,
> 
> On 10/06/2008 12:52 PM, Marc Kleine-Budde wrote:
> [...] something about git [...]
> 
> ...yes, old thread, but I like the subject (still).
> 
> I think we need a git tree. It's the second time our humble network
> maintainer merged some patches to early. IMHO both times related to bad
> communication.......

What do you mean? Usually we do not communicate anything to Dave for the
normal v1->v2->v3->... review and patch update process (this does not
excuse the bad quality of my last series). The problem is that it's not
easy for him to follow our work and therefore we need our own GIT tree.
That's also what Dave asks for. Apart from the tree he asks for someone
who acts as the one and only interface to him.

> I've setup a git repo on gitorious:
> 
> https://gitorious.org/linux-can/linux-can
> 
> It's based on net-next, and currently David's net-next/master is pushing
> there. It probably takes some time, the box pushing has just 4 mbit/s
> upstream.
> 
> Comments?

Apart from net-next, we may also need the net tree (as branch?).

Wolfgang.

> cheers, Marc
> 
> 
> 
> _______________________________________________
> Socketcan-core mailing list
> Socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
> https://lists.berlios.de/mailman/listinfo/socketcan-core
