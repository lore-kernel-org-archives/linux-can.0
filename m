From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
Date: Tue, 6 Feb 2018 09:52:12 +0100
Message-ID: <20180206085212.vpyatejmjqfa33ox@pengutronix.de>
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47781 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbeBFIwP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Feb 2018 03:52:15 -0500
Content-Disposition: inline
In-Reply-To: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

On Mon, Feb 05, 2018 at 02:31:32PM -0600, Elenita Hinds wrote:
> Below is a first attempt to make the j1939 kernel support be network
> namespace-aware (needed for my project). Please review, especially
> Kurt and Marc, as there maybe better ways of doing this. I'll
> re-submit a more official patch after getting feedback/comments.
> 
> Please note the TODO in j1939/transport.c, j1939tp_module_init().

Oleksij is also working on namespace support recently; unfortunately, he
is ill this week, so it might take some time until he'll answer your
mail. Please synchronize with him.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
