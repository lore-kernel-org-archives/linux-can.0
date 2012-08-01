From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [PATCH can-next v6] can: add tx/rx LED trigger support
Date: Thu, 2 Aug 2012 00:38:32 +0200
Message-ID: <20120801223832.GA2769@gmail.com>
References: <50191EA5.1040303@pengutronix.de>
 <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com>
 <501998D4.2040206@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <501998D4.2040206@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Wed, Aug 01, 2012 at 11:00:04PM +0200, Marc Kleine-Budde wrote:
> On 08/01/2012 08:21 PM, Fabio Baltieri wrote:
> > This patch implements the functions to add two LED triggers, named
> > <ifname>-tx and <ifname>-rx, to a canbus device driver.
> > 
> > Triggers are called from specific handlers by each CAN device driver and
> > can be disabled altogether with a Kconfig option.
> > 
> > The implementation keeps the LED on when the interface is UP and blinks
> > the LED on network activity at a configurable rate.
> > 
> > This only supports can-dev based drivers, as it uses some support field
> > in the can_priv structure.
> > 
> > Supported drivers should call devm_can_led_init() and can_led_event() as
> > needed.
> > 
> > Cleanup is handled automatically by devres, so no *_exit function is
> > needed.
> > 
> > Supported events are:
> > - CAN_LED_EVENT_OPEN: turn on tx/rx LEDs
> > - CAN_LED_EVENT_STOP: turn off tx/rx LEDs
> > - CAN_LED_EVENT_TX: trigger tx LED blink
> > - CAN_LED_EVENT_RX: trigger tx LED blink
> > 
> > Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> > ---
> > 
> > Hi all,
> > 
> > so, v6, change trigger names for fixed size allocation capped to (IFNAMSIZ + 4)
> > and removed kasprintf as suggested by Oliver (thanks!).
> > 
> > This also has the side effect of reducing the error path to just one check to
> > devres_alloc return value... nice!
> > 
> > I've put CAN_LED_NAME_SZ definition with the active function declaration,
> > but used sizeof(priv->tx_led_trig_name) as snprintf length argument in the
> > code, as it looks cleaner to me.
> > 
> > I'm not reposting the flexcan patch as it's not affected by the change.
> 
> Pushed to can-next/master, it even compiles now, as David has included
> some upstream branches.
> 
> I'm still taking Tested- and Acked-by for these patches.

Nice!  So, I'll start preparing some patch for other embedded CAN
controllers for test/review by developers who have access to the
actual hardware.

In the meantime, thanks to everyone on the list for reviews and ideas!

Cheers!
Fabio
