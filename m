From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] can: m_can: add support for handling arbitration error
Date: Mon, 14 Oct 2019 23:04:27 +0800
Message-ID: <201910142340.H1Itv6kZ%lkp@intel.com>
References: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@lists.01.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, eugen.hristev@microchip.com, ludovic.desroches@microchip.com, pankaj.dubey@samsung.com, rcsekar@samsung.com, Pankaj Sharma <pankj.sharma@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

Hi Pankaj,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]
[cannot apply to v5.4-rc3 next-20191014]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Pankaj-Sharma/can-m_can-add-support-for-handling-arbitration-error/20191014-193532

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/can/m_can/m_can.c:783:9-10: WARNING: return of 0/1 in function 'is_protocol_err' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
