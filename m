From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] slcan: Don't transmit uninitialized stack data in
 padding
Date: Wed, 01 Apr 2020 11:23:18 -0700 (PDT)
Message-ID: <20200401.112318.291287510384908654.davem@davemloft.net>
References: <20200401100639.20199-1-rpalethorpe@suse.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200401100639.20199-1-rpalethorpe@suse.com>
Sender: netdev-owner@vger.kernel.org
To: rpalethorpe@suse.com
Cc: linux-can@vger.kernel.org, keescook@chromium.org, netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com, mkl@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  1 Apr 2020 12:06:39 +0200

> struct can_frame contains some padding which is not explicitly zeroed in
> slc_bump. This uninitialized data will then be transmitted if the stack
> initialization hardening feature is not enabled (CONFIG_INIT_STACK_ALL).
> 
> This commit just zeroes the whole struct including the padding.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Fixes: a1044e36e457 ("can: add slcan driver for serial/USB-serial CAN adapters")
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied and queued up for -stable, thanks.
