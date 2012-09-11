From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 0/2] janz: fix support for Janz CMOD-IO revision 1.0 hardware
Date: Tue, 11 Sep 2012 15:58:13 -0700
Message-ID: <1347404295-7985-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-can@vger.kernel.org, sameo@linux.intel.com, "Ira W. Snyder" <iws@ovro.caltech.edu>
List-Id: linux-can.vger.kernel.org

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The Janz CMOD-IO Carrier Board hardware, revision 1.0 has several quirks
that do not effect newer revisions of the hardware. This series fixes both
quirks so that the old hardware works correctly.

The janz-cmodio MFD driver did not mask out the unused bits from the
modulbus_number sysfs file. On CMOD-IO revision 1.0, the upper bits have
random data. By masking out the bits, the correct number is presented to
userspace.

The janz-ican3 driver used the reset_assert and reset_deassert registers.
These registers do not exist on CMOD-IO revision 1.0. To work around the
problem, the hardware reset registers on the ican3 hardware itself are
used.

These are trivial fixes that fix support for some hardware which is currently
broken. It would be nice to get these into the current kernel release.

Ira W. Snyder (2):
  mfd/janz-cmodio: fix MODULBus number sysfs entry
  can: janz-ican3: fix support for older hardware revisions

 drivers/mfd/janz-cmodio.c    |    2 +-
 drivers/net/can/janz-ican3.c |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
1.7.8.6
