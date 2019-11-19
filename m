From: Pankaj Sharma <pankj.sharma@samsung.com>
Subject: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
Date: Tue, 19 Nov 2019 15:50:36 +0530
Message-ID: <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, dmurphy@ti.com, rcsekar@samsung.com, pankaj.dubey@samsung.com, Pankaj Sharma <pankj.sharma@samsung.com>
List-Id: linux-can.vger.kernel.org

The current code is failing while clock prepare enable because of not
getting proper clock from platform device. 

[    0.852089] Call trace:
[    0.854516]  0xffff0000fa22a668
[    0.857638]  clk_prepare+0x20/0x34
[    0.861019]  m_can_runtime_resume+0x2c/0xe4
[    0.865180]  pm_generic_runtime_resume+0x28/0x38
[    0.869770]  __rpm_callback+0x16c/0x1bc
[    0.873583]  rpm_callback+0x24/0x78
[    0.877050]  rpm_resume+0x428/0x560
[    0.880517]  __pm_runtime_resume+0x7c/0xa8
[    0.884593]  m_can_clk_start.isra.9.part.10+0x1c/0xa8
[    0.889618]  m_can_class_register+0x138/0x370
[    0.893950]  m_can_plat_probe+0x120/0x170
[    0.897939]  platform_drv_probe+0x4c/0xa0
[    0.901924]  really_probe+0xd8/0x31c
[    0.905477]  driver_probe_device+0x58/0xe8
[    0.909551]  device_driver_attach+0x68/0x70
[    0.913711]  __driver_attach+0x9c/0xf8
[    0.917437]  bus_for_each_dev+0x50/0xa0
[    0.921251]  driver_attach+0x20/0x28
[    0.924804]  bus_add_driver+0x148/0x1fc
[    0.928617]  driver_register+0x6c/0x124
[    0.932431]  __platform_driver_register+0x48/0x50
[    0.937113]  m_can_plat_driver_init+0x18/0x20
[    0.941446]  do_one_initcall+0x4c/0x19c
[    0.945259]  kernel_init_freeable+0x1d0/0x280
[    0.949591]  kernel_init+0x10/0x100
[    0.953057]  ret_from_fork+0x10/0x18
[    0.956614] Code: 00000000 00000000 00000000 00000000 (fa22a668) 
[    0.962681] ---[ end trace 881f71bd609de763 ]---
[    0.967301] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

A device driver for CAN controller hardware registers itself with the
Linux network layer as a network device. So, the driver data for m_can
should ideally be of type net_device. 

Further even when passing the proper net device in probe function the
code was hanging because of the function m_can_runtime_resume() getting
recursively called from m_can_class_resume().

Pankaj Sharma (2):
  can: m_can_platform: set net_device structure as driver data
  can: m_can_platform: remove unnecessary m_can_class_resume() call

 drivers/net/can/m_can/m_can_platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.7.4
