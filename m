From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 1/9] can: af_can: export can_sock_destruct()
Date: Tue, 12 Nov 2019 12:45:39 +0100
Message-ID: <20191112114539.zjluqnpo3cynhssi@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
 <20191112111600.18719-2-o.rempel@pengutronix.de>
 <20191112113724.pff6atmyii5ri4my@pengutronix.de>
 <1da06748-6233-b65e-9b02-da5a867a4ecb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1da06748-6233-b65e-9b02-da5a867a4ecb@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, wg@grandegger.com, netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Marc,

On Tue, Nov 12, 2019 at 12:39:27PM +0100, Marc Kleine-Budde wrote:
> On 11/12/19 12:37 PM, Uwe Kleine-König wrote:
> > On Tue, Nov 12, 2019 at 12:15:52PM +0100, Oleksij Rempel wrote:
> >> +EXPORT_SYMBOL(can_sock_destruct);
> > 
> > If the users are only expected to be another can module, it might make
> > sense to use a namespace here?!
> 
> How?

Use

	EXPORT_SYMBOL_NS(can_sock_destruct, CAN)

instead of the plain EXPORT_SYMBOL, and near the declaration of
can_sock_destruct or in the source that makes use of the symbol add:

	MODULE_IMPORT_NS(CAN);

See https://lwn.net/Articles/760045/ for some details.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
