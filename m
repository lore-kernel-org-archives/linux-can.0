From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] Use strcmp instead of strncmp
Date: Wed, 14 Nov 2012 10:07:15 +0100
Message-ID: <7396967.nBD5445xda@ws-stein>
References: <1352821642-18791-1-git-send-email-alexander.stein@systec-electronic.com> <50A2AD0A.6040005@pengutronix.de> <20121114085537.GB82180@airbook.eia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:47003 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932144Ab2KNJHT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 04:07:19 -0500
In-Reply-To: <20121114085537.GB82180@airbook.eia.lan>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hello,

On Wednesday 14 November 2012 09:55:37, Kurt Van Dijck wrote:
> On Tue, Nov 13, 2012 at 09:26:50PM +0100, Marc Kleine-Budde wrote:
> > On 11/13/2012 04:47 PM, Alexander Stein wrote:
> > > This bug was detected by the clang warning:
> > > libsocketcan.c:384:16: warning: argument to 'sizeof' in 'strncmp' call
> > > is the same expression as the source; did you mean to provide an
> > > explicit length? [-Wsizeof-pointer-memaccess]
> > > sizeof(name)) != 0)
> > > ~~~~~~~^~~~~~
> strlen() requires a null terminator. Is that always present?
> Unfortunately, I've no access to the libsocketcan code today...
> > > 
> > > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> > > ---
> > >  src/libsocketcan.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/src/libsocketcan.c b/src/libsocketcan.c
> > > index fedcbdc..3ad2a6c 100644
> > > --- a/src/libsocketcan.c
> > > +++ b/src/libsocketcan.c
> > > @@ -364,6 +364,7 @@ static int do_get_nl_link(int fd, __u8 acquire, 
const char *name, void *res)
> > >  		     nl_msg = NLMSG_NEXT(nl_msg, u_msglen)) {
> > >  			int type = nl_msg->nlmsg_type;
> > >  			int len;
> > > +			int namelen = strlen(name);
> > >  
> > >  			if (type == NLMSG_DONE) {
> > >  				done++;
> > > @@ -381,7 +382,7 @@ static int do_get_nl_link(int fd, __u8 acquire, 
const char *name, void *res)
> > >  
> > >  			if (strncmp
> > >  			    ((char *)RTA_DATA(tb[IFLA_IFNAME]), name,
> > > -			     sizeof(name)) != 0)
> > > +			     namelen) != 0)
> > 
> > What about using strcmp() instead. AFAIK it will compare until it finds
> > the end of the string in one of the strings, so it should be no
> > difference here?
> if name contains a null terminator, using strcmp() is even better.

name is passed directly from public API functions like can_get_state. So the 
user has to provide the null terminator. As this cannot be garuanteed it might 
better to use strlen on (char *)RTA_DATA(tb[IFLA_IFNAME]).
BTW: there is no need to introduce a new variable. sizeof can simply be 
replaced by strlen.

Best regards,
Alexander

