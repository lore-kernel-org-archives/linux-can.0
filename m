From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: generic addr struct
Date: Thu, 17 Aug 2017 10:31:45 +0200
Message-ID: <20170817083145.GB7870@airbook.vandijck-laurijssen.be>
References: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:51780 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdHQIdd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 04:33:33 -0400
Content-Disposition: inline
In-Reply-To: <cbeb1c36-7ea5-353a-cb9d-7d1c0d3dc997@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>


> I'd like to introduce a generic j1939 address struct, it's used inside
> the kernel only, so no userspace visible changes. What about:
> 
> > +struct j1939_addr {
> > +       name_t src_name;
> > +       name_t dst_name;
> > +       pgn_t pgn;
> > +
> > +       u8 sa;
> > +       u8 da;
> > +};

Long ago, I had such a structure, and found that in most cases, little
members were used. I found the structure containing too many members
more confusing and got rid of it :-)
> 
> ...or use src_addr and dst_addr, instead of sa and da?
IMO, sa & da are clear terminology.
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



