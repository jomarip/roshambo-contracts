pragma solidity >=0.4.25 <0.6.0;

import "./openZeppelin/access/Roles.sol";

contract AdminRole {
    using Roles for Roles.Role;

    event AdminAdded(address indexed account);
    event AdminRemoved(address indexed account);

    Roles.Role private _admins;

    constructor () internal {
        _addAdmin(msg.sender);
    }

    modifier onlyAdmin() {
        require(isAdmin(msg.sender));
        _;
    }
    
     /**
     * @dev Check if the account role is the admin.
     * @return bool
     */
    function isAdmin(address account) public view returns (bool) {
        return _admins.has(account);
    }

     /**
     * @dev Public/Main function to add specified admin only if initiated by the current admin. Run the _addAdmin function
     * 
     */
    function addAdmin(address account) public onlyAdmin {
        _addAdmin(account);
    }
    
    /**
     * @dev Remove the message sender as admin.  Run the _removeAdmin function.
     *
     */
    function renounceAdmin() public {
        _removeAdmin(msg.sender);
    }

    /**
     * @dev internal call to add an address to the admin list. Initiated by addAdmin. Emit for logging.
     * 
     */
    function _addAdmin(address account) internal {
        _admins.add(account);
        emit AdminAdded(account);
    }
    
    /**
     * @dev Internal call to remove an address from the admin list. Initiated by renounceAdmin.  Emit for logging.
     *
     */
    function _removeAdmin(address account) internal {
        _admins.remove(account);
        emit AdminRemoved(account);
    }
}