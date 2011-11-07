From: Kurt Van Dijck <kurt.van.dijck-/BeEPy95v10@public.gmane.org>
Subject: Re: git repos @ gitorious.org
Date: Mon, 7 Nov 2011 09:07:25 +0100
Message-ID: <20111107080712.GA279@e-circ.dyndns.org>
References: <4EB1A448.6000703@hartkopp.net> <4EB1C132.2070103@pengutronix.de>
	<20111103130841.GG317@e-circ.dyndns.org>
	<20111104161655.GC18026@e-circ.dyndns.org>
	<4EB69430.7070801@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4EB69430.7070801-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Sun, Nov 06, 2011 at 03:05:36PM +0100, Marc Kleine-Budde wrote:
> On 11/04/2011 05:16 PM, Kurt Van Dijck wrote:
> > On Thu, Nov 03, 2011 at 02:08:41PM +0100, Kurt Van Dijck wrote:
> >> On Wed, Nov 02, 2011 at 11:16:18PM +0100, Marc Kleine-Budde wrote:
> >>> On 11/02/2011 09:12 PM, Oliver Hartkopp wrote:
> >>>>
> >>>> https://gitorious.org/~<kurts_account>/linux-can/can-modules-j1939
> >>>> https://gitorious.org/~<kurts_account>/linux-can/can-utils-j1939
> > 
> > Since the can-j1939-modules require one to use a modified iproute2,
> > I wanted to create an iproute-j1939 within linux-can, but I see no way
> > to accomplish this.
> > 
> > Any opinions on how to proceed?
> 
> Google for the iproute2 git upstream, clone it, modify it. Create a
> iproute2 git repo on gitorious, push your changes there.

I see not how to create on Gitorious a linux-can/iproute2-can-j1939
or similar. It looks to me as if I need to create a project first.
> 
> The git workflow is basically the same as you did to copy the j1939
> can-utils to your repo.
> 
> Finally send a pull request to the iprout2 upstream.
> 
> cheers, Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
