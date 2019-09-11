From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the net-next tree
Date: Wed, 11 Sep 2019 11:02:15 +0200
Message-ID: <20190911090215.n776azhwewfbr6xf@pengutronix.de>
References: <20190911004103.3480fa40@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190911004103.3480fa40@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, The j1939 authors <linux-can@vger.kernel.org>, Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, kbuild test robot <lkp@intel.com>, Maxime Jayat <maxime.jayat@mobile-devices.fr>, Robin van der Gracht <robin@protonic.nl>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

Hi Stephen,

On Wed, Sep 11, 2019 at 12:41:03AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> 
> is missing a Signed-off-by from its author.
> 
> [Not sure if I should complain about this one ...]

Here is the original pull request message for this patch series:
"The final patch is the collective effort of many entities (The j1939
authors: Oliver Hartkopp, Bastian Stender, Elenita Hinds, kbuild test
robot, Kurt Van Dijck, Maxime Jayat, Robin van der Gracht, Oleksij
Rempel, Marc Kleine-Budde). It adds support of SAE J1939 protocol to the
CAN networking stack."
https://www.mail-archive.com/netdev@vger.kernel.org/msg313476.html

Since the patch can be hardly assigned to one author we deiced to use
address of CAN mailing list.

Best regards,
Oleksij Rempel
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
