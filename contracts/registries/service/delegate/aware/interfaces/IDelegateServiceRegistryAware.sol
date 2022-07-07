// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IDelegateServiceRegistryAware {

  function getDelegateServiceRegistry() view external returns (address delegateServiceRegistry);

}