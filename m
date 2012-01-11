From: Kurt Van Dijck <kurt.van.dijck-/BeEPy95v10@public.gmane.org>
Subject: Re: [PATCH 0/4] import kernel header files into tree
Date: Wed, 11 Jan 2012 14:37:07 +0100
Message-ID: <20120111133707.GI314@e-circ.dyndns.org>
References: <1322831813-9729-1-git-send-email-mkl@pengutronix.de>
	<4F0D7FF0.5020306@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F0D7FF0.5020306-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Wed, Jan 11, 2012 at 01:26:24PM +0100, Marc Kleine-Budde wrote:
> On 12/02/2011 02:16 PM, Marc Kleine-Budde wrote:
> > Hello,
> > 
> > this patch series imports the kernel header files into the can-utils tree
> > and adopts both Makefile and autotools. The autotools complete the
> > "make distcheck" test and are tested for cross compildation.
> > Plain old makefile support is still working, too.
> > 
> > Please test and comment,

I must have missed this call. So put my questions way too late.

Why does commit 77de10356fe0eca7bce73e9c3ac4ed32edfc10e5
say 'kernel headers' where it actully puts the can-modules headers
(i.e. include/socketcan) ?

Kurt
> > regards, Marc
> 
> I've pushed the series to master + another patch replacing the contact
> email by linux-can-u79uwXL29TaiAVqoAR/hOA@public.gmane.org
> 
> Marc
