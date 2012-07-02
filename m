From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net-next v3] em_canid: Ematch rule to match CAN frames
 according to their identifiers
Date: Mon, 02 Jul 2012 19:04:52 +0200
Message-ID: <4FF1D4B4.40907@hartkopp.net>
References: <1341241568-13438-1-git-send-email-lisovy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1341241568-13438-1-git-send-email-lisovy@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Rostislav Lisovy <lisovy@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, lartc@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz
List-Id: linux-can.vger.kernel.org

On 02.07.2012 17:06, Rostislav Lisovy wrote:

> This ematch makes it possible to classify CAN frames (AF_CAN) according
> to their identifiers. This functionality can not be easily achieved with
> existing classifiers, such as u32, because CAN identifier is always stored
> in native endianness, whereas u32 expects Network byte order.
> 
> Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>


Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Rostislav!
