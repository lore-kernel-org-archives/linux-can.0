From: Maksim Salau <maksim.salau@gmail.com>
Subject: Re: [PATCH] net: can: usb: gs_usb: Fix buffer on stack
Date: Sun, 23 Apr 2017 20:18:03 +0300
Message-ID: <20170423201803.59394deb@gmail.com>
References: <20170422165626.10534-1-maksim.salau@gmail.com>
        <CAOMZO5DLdR00FY01r2z=RvSrn4vNEZ+Z3OS0KWB95DGt=3fh2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5DLdR00FY01r2z=RvSrn4vNEZ+Z3OS0KWB95DGt=3fh2w@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Maximilian Schneider <max@schneidersoft.net>, Hubert Denkmair <hubert@denkmair.de>, Wolfram Sang <wsa-dev@sang-engineering.com>, Ethan Zonca <e@ethanzonca.com>, linux-can@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

> > +       struct gs_identify_mode *imode = NULL;  
> 
> No need to assign imode to NULL here.

Thanks, Fabio.

I'll fix this in v2.

Maksim
