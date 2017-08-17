From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: generic addr struct
Date: Thu, 17 Aug 2017 10:53:00 +0200
Message-ID: <20170817085300.GC7870@airbook.vandijck-laurijssen.be>
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
 <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
 <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:58384 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdHQIyt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 04:54:49 -0400
Content-Disposition: inline
In-Reply-To: <fe4c8270-737d-92c7-fb61-d195eacf9a68@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>


> On 08/17/2017 10:31 AM, Kurt Van Dijck wrote:
> > 
> >> I'd like to introduce a generic j1939 address struct, it's used inside
> >> the kernel only, so no userspace visible changes. What about:
> >>
> >>> +struct j1939_addr {
> >>> +       name_t src_name;
> >>> +       name_t dst_name;
> >>> +       pgn_t pgn;
> >>> +
> >>> +       u8 sa;
> >>> +       u8 da;
> >>> +};
> > 
> > Long ago, I had such a structure, and found that in most cases, little
> > members were used. I found the structure containing too many members
> > more confusing and got rid of it :-)
> 
> I'm using it in struct j1939_sock::addr ...
> 
> > @@ -43,14 +43,7 @@ struct j1939_sock {                                                                                                                                                                                                                                                    
> > 
> >         int ifindex_started; /* ifindex of netdev */
> > 
> > -       struct {                                                                                                                                                                                                                                                                          
> > -               name_t src;                                                                                                                                                                                                                                                               
> > -               name_t dst;                                                                                                                                                                                                                                                               
> > -               pgn_t pgn;                                                                                                                                                                                                                                                                
> > -                                                                                                                                                                                                                                                                                         
> > -               u8 sa, da;                                                                                                                                                                                                                                                                
> > -       } addr;                                                                                                                                                                                                                                                                           
> > -                                                                                                                                                                                                                                                                                         
> > +       struct j1939_addr addr;                                                                                                                                                                                                                                                           
> >         struct j1939_filter *filters;
> >         int nfilters;
> 
> ... and in struct j1939_sk_buff_cb:

It's clear that you can replace this indeed.

> 
> >  /* control buffer of the sk_buff */
> >  struct j1939_sk_buff_cb {
> > -       pgn_t pgn;                                                                                                                                                                                                                                                                        
> > +       struct j1939_addr addr;                                                                                                                                                                                                                                                           
> >         priority_t priority;
> > -       u8 srcaddr;                                                                                                                                                                                                                                                                       
> > -       u8 dstaddr;                                                                                                                                                                                                                                                                       
> > -       name_t srcname;                                                                                                                                                                                                                                                                   
> > -       name_t dstname;                                                                                                                                                                                                                                                                   
> 
> Both have 2x name and 2x addr and the pgn.

the max size of j1939_sk_buff_cb is limited, and using structs
may consume more depending on the platform and alignment.
I had troubles in the past, hence the decomposed definition.
Looking at the latest version, it seems to have some room left, and
using structs will succeed :-)

> 
> >> ...or use src_addr and dst_addr, instead of sa and da?
> > IMO, sa & da are clear terminology.
> 
> Ok
> 
> Thanks,
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



