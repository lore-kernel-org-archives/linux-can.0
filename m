From: kbuild test robot <fengguang.wu@intel.com>
Subject: [mkl-can-next:rx-fifo-debug 13/18]
 drivers/net/can/at91_can.c:924:40: sparse: not enough arguments for function
 can_rx_fifo_irq_offload
Date: Tue, 5 Jul 2016 04:01:54 +0800
Message-ID: <201607050447.hWI8zZGf%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8328 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbcGDUDA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 4 Jul 2016 16:03:00 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: kbuild-all@01.org, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git rx-fifo-debug
head:   39ac410909de789c7ffc82999b8d6099dc6540b0
commit: 3d2d3666fe5f0079d2d6969dbcc7712f1d40087e [13/18] can: rx-fifo, flexcan: only only try to read mailbox if pending
reproduce:
        # apt-get install sparse
        git checkout 3d2d3666fe5f0079d2d6969dbcc7712f1d40087e
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:232:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/net/can/at91_can.c:924:40: sparse: not enough arguments for function can_rx_fifo_irq_offload
   drivers/net/can/at91_can.c: In function 'at91_irq':
   drivers/net/can/at91_can.c:924:3: error: too few arguments to function 'can_rx_fifo_irq_offload'
      can_rx_fifo_irq_offload(&priv->rx_fifo);
      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/can/at91_can.c:31:0:
   include/linux/can/rx-fifo.h:55:5: note: declared here
    int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo, u64 reg);
        ^~~~~~~~~~~~~~~~~~~~~~~

vim +924 drivers/net/can/at91_can.c

99c4a634 David S. Miller   2009-09-25  908  	if (!reg_sr)
89561333 Marc Kleine-Budde 2015-05-10  909  		return IRQ_NONE;
99c4a634 David S. Miller   2009-09-25  910  
89561333 Marc Kleine-Budde 2015-05-10  911  	/* Error interrupt? -> rx-fifo */
89561333 Marc Kleine-Budde 2015-05-10  912  	if (reg_sr & AT91_IRQ_ERR_FRAME) {
89561333 Marc Kleine-Budde 2015-05-10  913  		/* The error bits are clear on read,
99c4a634 David S. Miller   2009-09-25  914  		 * save for later use.
99c4a634 David S. Miller   2009-09-25  915  		 */
99c4a634 David S. Miller   2009-09-25  916  		priv->reg_sr = reg_sr;
89561333 Marc Kleine-Budde 2015-05-10  917  
89561333 Marc Kleine-Budde 2015-05-10  918  		at91_write(priv, AT91_IDR, AT91_IRQ_ERR_FRAME);
89561333 Marc Kleine-Budde 2015-05-10  919  		can_rx_fifo_irq_error(&priv->rx_fifo);
99c4a634 David S. Miller   2009-09-25  920  	}
99c4a634 David S. Miller   2009-09-25  921  
89561333 Marc Kleine-Budde 2015-05-10  922  	/* Receive interrupt? */
89561333 Marc Kleine-Budde 2015-05-10  923  	if (reg_sr & (get_irq_mb_rx(priv)))
89561333 Marc Kleine-Budde 2015-05-10 @924  		can_rx_fifo_irq_offload(&priv->rx_fifo);
89561333 Marc Kleine-Budde 2015-05-10  925  
99c4a634 David S. Miller   2009-09-25  926  	/* Transmission complete interrupt */
79008997 Marc Kleine-Budde 2011-05-03  927  	if (reg_sr & get_irq_mb_tx(priv))
99c4a634 David S. Miller   2009-09-25  928  		at91_irq_tx(dev, reg_sr);
99c4a634 David S. Miller   2009-09-25  929  
99c4a634 David S. Miller   2009-09-25  930  	at91_irq_err(dev);
99c4a634 David S. Miller   2009-09-25  931  
89561333 Marc Kleine-Budde 2015-05-10  932  	return IRQ_HANDLED;

:::::: The code at line 924 was first introduced by commit
:::::: 895613338becbd1eabf01dfc7b50f1dc3b25ba33 can: at91_can: switch to rx-fifo implementation

:::::: TO: Marc Kleine-Budde <mkl@pengutronix.de>
:::::: CC: Marc Kleine-Budde <mkl@pengutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
