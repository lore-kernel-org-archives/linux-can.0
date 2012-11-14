From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH] Use strcmp instead of strncmp
Date: Wed, 14 Nov 2012 09:55:37 +0100
Message-ID: <20121114085537.GB82180@airbook.eia.lan>
References: <1352821642-18791-1-git-send-email-alexander.stein@systec-electronic.com>
 <50A2AD0A.6040005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:40326 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab2KNIzn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 03:55:43 -0500
Content-Disposition: inline
In-Reply-To: <50A2AD0A.6040005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

On Tue, Nov 13, 2012 at 09:26:50PM +0100, Marc Kleine-Budde wrote:
> On 11/13/2012 04:47 PM, Alexander Stein wrote:
> > This bug was detected by the clang warning:
> > libsocketcan.c:384:16: warning: argument to 'sizeof' in 'strncmp' call
> > is the same expression as the source; did you mean to provide an
> > explicit length? [-Wsizeof-pointer-memaccess]
> > sizeof(name)) != 0)
> > ~~~~~~~^~~~~~
strlen() requires a null terminator. Is that always present?
Unfortunately, I've no access to the libsocketcan code today...
> > 
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > ---
> >  src/libsocketcan.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/src/libsocketcan.c b/src/libsocketcan.c
> > index fedcbdc..3ad2a6c 100644
> > --- a/src/libsocketcan.c
> > +++ b/src/libsocketcan.c
> > @@ -364,6 +364,7 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
> >  		     nl_msg = NLMSG_NEXT(nl_msg, u_msglen)) {
> >  			int type = nl_msg->nlmsg_type;
> >  			int len;
> > +			int namelen = strlen(name);
> >  
> >  			if (type == NLMSG_DONE) {
> >  				done++;
> > @@ -381,7 +382,7 @@ static int do_get_nl_link(int fd, __u8 acquire, const char *name, void *res)
> >  
> >  			if (strncmp
> >  			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
> > -			     sizeof(name)) != 0)
> > +			     namelen) != 0)
> 
> What about using strcmp() instead. AFAIK it will compare until it finds
> the end of the string in one of the strings, so it should be no
> difference here?
if name contains a null terminator, using strcmp() is even better.
> 
> >  				continue;
> >  
> >  			if (tb[IFLA_LINKINFO])
> > 
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


